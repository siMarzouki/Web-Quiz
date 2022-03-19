import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import '../screens/DashboardScreen.dart';
import '../screens/LoginScreen.dart';
import '../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(scaffoldColor);
    Future.delayed(Duration(seconds: 3), () {
      if (appStore.isLoggedIn) {
        DashboardScreen().launch(context, isNewTask: true);
      } else {
        LoginScreen().launch(context, isNewTask: true);
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Color(0xFF112d4e),
          Color(0xff4c617a),
        ],
      )),
      child: ScaleTransition(
        scale: _animation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/coding.png",
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "WEB",
                  style: TextStyle(
                      fontSize: 70,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  "QUIZ",
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 8,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
