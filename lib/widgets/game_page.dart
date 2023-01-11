import 'package:flutter/material.dart';
import 'package:playground/match_background/match_container_controller.dart';

import '../match_background/match_contanier.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late MatchContainerController bgController = MatchContainerController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MatchContainer(
          controller: bgController,
          topTitle: '隨機匹配',
          bottomTitle: '邀請他人',
          centerTitle: '真心話大冒險',
          tipsMsg: '点击头像邀请',

          // rotatedChild: Container(color: Colors.green),
        ),
        Opacity(
          opacity: 0.3,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => bgController.open(),
                    child: const Text('open')),
                ElevatedButton(
                    onPressed: () => bgController.close(),
                    child: const Text('close')),
                ElevatedButton(
                    onPressed: () => bgController.rotate(),
                    child: const Text('rotate')),
                ElevatedButton(
                    onPressed: () => bgController.rotateBack(),
                    child: const Text('rotate back'))
              ],
            ),
          ),
        )
      ],
    );
  }
}
