import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class AutoCompletePage extends StatelessWidget {
  const AutoCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.trim() == '') return [];
        return ['alice', 'bob', 'charles']
            .where((element) => element.contains(textEditingValue.text));
      },
      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) =>
          TextFormField(
        focusNode: focusNode,
        controller: textEditingController,
      ),
      optionsViewBuilder: (
        BuildContext context,
        void Function(String) onSelected,
        Iterable<String> options,
      ) {
        return Material(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final String option = options.elementAt(index);
              return ListTile(
                title: Text(option),
                hoverColor: Colors.red,
                onTap: () => onSelected(option),
              );
            },
            itemCount: options.length,
            itemExtent: 50,
          ),
        );

        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 0.0,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 200, maxWidth: Get.width - 128),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.red,
                    onTap: () {
                      onSelected(option);
                    },
                    child: Builder(builder: (BuildContext context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Text((option)),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
        return Container(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: options
                  .map((e) => Container(
                        width: Get.width - 128,
                        color: Colors.red,
                        child: Text(e,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            )),
                      ))
                  .toList()),
        );
      },
    ));
  }
}
