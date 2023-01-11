import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProcessBarPage extends StatefulWidget {
  const ProcessBarPage({super.key, this.totalSecondes = 15});
  final int totalSecondes;

  @override
  State<ProcessBarPage> createState() => _ProcessBarPageState();
}

class _ProcessBarPageState extends State<ProcessBarPage>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: widget.totalSecondes),
  );

  double get percent => _controller.drive(Tween(begin: 1.0, end: 0.0)).value; //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      floatingActionButton: FloatingActionButton(onPressed: () {
        _controller
          ..reset()
          ..forward();
      }),
      body: Center(
          child: AnimatedBuilder(
        builder: (context, _) {
          return CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 10.0,
            percent: percent,
            reverse: true,
            center: Text(
              (percent * widget.totalSecondes).round().toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 70.0,
                color: Colors.white,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.white.withOpacity(0.5),
            progressColor: Colors.white,
          );
        },
        animation: _controller,
      )),
    );
  }
}
