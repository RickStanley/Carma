import 'package:carma/home.dart';
import 'package:carma/intro/step1.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  static const ROUTE_NAME = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 78,
          ),
          Hero(
            tag: "the-title",
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                "Carma",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 76,
          ),
          Column(
            children: [
              stickmanButton(
                context,
                "Let's begin!",
                "stickman_go",
                onTap: () {
                  Navigator.pushNamed(context, Home.ROUTE_NAME);
                },
              ),
              SizedBox(
                height: 50,
              ),
              stickmanButton(
                context,
                "What is it?",
                "stickman_scroll",
                onTap: () {
                  Navigator.pushNamed(context, IntroStep1.ROUTE_NAME);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector stickmanButton(
      BuildContext context, String label, String stickmanStance,
      {void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 82,
            height: 82,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  child: Image.asset("assets/stickmen/$stickmanStance.webp"),
                )
              ],
            ),
          ),
          Stack(
            overflow: Overflow.visible,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.headline3,
              ),
              Positioned(
                top: 16,
                right: -14,
                child: Icon(
                  Icons.arrow_forward,
                  size: 22,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
