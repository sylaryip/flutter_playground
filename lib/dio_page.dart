import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void getBaidu(void v) async {
  var res = await Dio().get('http://www.baidu.com');
  log(res.data.toString());
}

class DioPage extends StatefulWidget {
  const DioPage({super.key});

  @override
  State<DioPage> createState() => _DioPageState();
}

class _DioPageState extends State<DioPage> {
  String content = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        compute(getBaidu, null);
      }),
    );
  }
}
