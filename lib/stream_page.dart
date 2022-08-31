import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({Key? key}) : super(key: key);

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  final numberStream = NumberCreator().stream.asBroadcastStream();
  late StreamSubscription<int> mySubscriptions;

  int myInt = 0;

  @override
  void initState() {
    super.initState();
    mySubscriptions = numberStream.listen((data) {
      setState(() {
        myInt = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          StreamBuilder<int>(
            stream: numberStream,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Text('${snapshot.data!}');
              }
              return const SizedBox();
            },
          ),
          Positioned(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    mySubscriptions.pause();
                  },
                  child: const Text('pause'),
                ),
                TextButton(
                  onPressed: () {
                    mySubscriptions.resume();
                  },
                  child: const Text('resume'),
                ),
                TextButton(
                  onPressed: () {
                    mySubscriptions.cancel();
                    print('test');
                  },
                  child: const Text('cancel'),
                ),
                Text('$myInt'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NumberCreator {
  NumberCreator() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _controller.sink.add(_count);
      _count++;
    });
  }

  int _count = 0;

  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;
}
