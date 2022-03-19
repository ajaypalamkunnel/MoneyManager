import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'screen_home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 4700), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ScreenHome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade900,
        body: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'M',
                style: TextStyle(
                  color: Colors.yellow.shade800,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'oney',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontFamily: 'Bobbers',
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 5),
              Container(
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      'Manager',
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontFamily: 'Bobbers',
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(milliseconds: 400),
                    ),
                  ],
                  totalRepeatCount: 2,
                  pause: const Duration(milliseconds: 90),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ],
          ),
        ));
  }
}
