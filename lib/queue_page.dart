import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key});

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class AsyncQueue<T> {
  Future<T?> _current = Future.value(null);
  Future<T?> add(FutureOr<T> Function() task) {
    FutureOr<T> wrapper(void _) => task();
    return _current = _current.then(wrapper, onError: wrapper);
  }
}

class TaskRunner {
  final Queue _input = Queue();
  final Completer _completer = Completer();

  var isBusy = false;

  void init() async {
    while (!_completer.isCompleted) {
      if (_input.isEmpty || isBusy) {
        print('waiting or idle');
        await Future.delayed(const Duration(seconds: 1));
        continue;
      }
      print('hadData');
      var task = _input.removeFirst() as Function;
      isBusy = true;
      await task.call();
      isBusy = false;
      print('task:$task');
    }
  }

  TaskRunner() {
    _completer.future;
    init();
  }

  void close() {
    _completer.complete();
  }

  void add(value) {
    _input.add(value);
  }
}

class _QueuePageState extends State<QueuePage> {
  final Random _rnd = Random();

  late TaskRunner runner;
  late AsyncQueue queue;
  @override
  void initState() {
    super.initState();
    // runner = TaskRunner();
    queue = AsyncQueue();
  }

  @override
  void dispose() {
    // runner.close();
    super.dispose();
  }

  Future genDialog(int i) {
    return Get.generalDialog(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Center(
            child: Container(
              height: 300,
              width: 300,
              color: Colors.white,
              child: Text('$i'),
            ),
          );
        },
        barrierLabel: '$i',
        barrierDismissible: true);
  }

  void onPress() async {
    queue.add(() => genDialog(1));
    queue.add(() => Future.delayed(Duration(seconds: 3), () => genDialog(2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onPress,
              child: const Text('add events'),
            ),
          ],
        ),
      ),
    );
  }
}
