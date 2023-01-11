import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchTitle extends StatelessWidget {
  const MatchTitle({
    super.key,
    required this.content,
  });
  final String content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset(6.w, 6.w),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 80.sp,
              color: const Color(0x33000000),
            ),
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 80.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
