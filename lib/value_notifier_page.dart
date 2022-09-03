import 'package:flutter/material.dart';

class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({super.key});

  @override
  State<ValueNotifierPage> createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {
  final ValueNotifier<int> counterValueNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    counterValueNotifier.addListener(() {
      print("change");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: onFABClick,
          child: const Icon(
            Icons.add,
          )),
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueChangeTest(counterValueNotifier: counterValueNotifier)
          ],
        ),
      ),
    );
  }

  void onFABClick() {
    counterValueNotifier.value += 2;
  }
}

class ValueChangeTest extends StatelessWidget {
  const ValueChangeTest({super.key, required this.counterValueNotifier});
  final ValueNotifier<int> counterValueNotifier;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: counterValueNotifier,
      builder: ((context, child) {
        return Text('counter2: ${counterValueNotifier.value}');
      }),
    );
  }
}
