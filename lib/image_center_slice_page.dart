import 'package:flutter/material.dart';

class ImageCenterSlicePage extends StatelessWidget {
  const ImageCenterSlicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/bg_test_result_343@2x.png',
                height: 1200,
                width: 320,
                centerSlice: const Rect.fromLTRB(20, 100, 300, 300),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/bg_test_result_343@2x.png',
                height: 600,
                width: 320,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
