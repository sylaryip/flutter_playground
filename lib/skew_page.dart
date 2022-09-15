import 'package:flutter/material.dart';

class SkewPage extends StatelessWidget {
  const SkewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = Matrix4.identity()
      ..setEntry(3, 2, 0.003)
      ..rotateX(-45);
    print(value);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Transform(
          transform: value,
          alignment: FractionalOffset.center,
          child: Container(
              // alignment: Alignment.center,
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(35),
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "In 2045 AD ",
                          style: TextStyle(color: Color(0xFF21D684)),
                          children: [
                            TextSpan(
                              text:
                                  " human beings discovered an terrestrial planet in the Milky Way, and began to recruit young volunteers to develop it.\n\n",
                              style: TextStyle(color: Color(0xFFC1CCCC)),
                            ),
                          ]),
                      TextSpan(
                          text: "Volunteers need to ",
                          style: TextStyle(color: Color(0xFFC1CCCC)),
                          children: [
                            TextSpan(
                              text: "ind the best match ",
                              style: TextStyle(color: Color(0xFF21D684)),
                            ),
                            TextSpan(
                              text:
                                  " for them to build a new home together after the journey begins.\n \n ",
                              style: TextStyle(color: Color(0xFFC1CCCC)),
                            ),
                          ]),
                      TextSpan(
                        text:
                            "Congratulations, you are the chosen one, you can start boarding after registering your information.",
                        style: TextStyle(color: Color(0xFFC1CCCC)),
                      ),
                    ]),
              )),
        ),
      ),
    );
  }
}
