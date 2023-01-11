import 'package:flutter/material.dart';

class ExpandTestPage extends StatelessWidget {
  const ExpandTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    'abc' * 10,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Text(', 200'),
                const Text(' aaa'),
                const Text(' bbb'),
              ],
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            '2020-10-10',
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
