import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

final mylogo = GradientText(
  'MoAzMar',
    style: TextStyle(
      fontSize: 25.0,
      letterSpacing: 2,
      fontFamily: "Roboto",
      fontWeight: FontWeight.bold),
  colors: [Colors.deepOrange, Color(0xffDA44bb), Color(0xff8921aa)],
);

final madeByMe = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("Made with "),
    Icon(
      Icons.favorite,
      color: Colors.pinkAccent,
    ),
    Text("By "),
    mylogo
  ],
);
