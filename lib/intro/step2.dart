import 'package:carma/intro/step3.dart';
import 'package:carma/utils/carmaWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IntroStep2 extends StatelessWidget {
  static const ROUTE_NAME = "/intro/step/2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CarmaIntroAppBar(
        stepNumber: 2,
        stepTitle: "Always two there are.\nNo more, no less.",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyText1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RuleOfTwo(
                      iconSize: Size(100.0, 100.0),
                    ),
                    SizedBox(
                      height: 23.0,
                    ),
                    Text(
                      "Situation 1",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Did your “friend” type a sentence with a “dot” at the end, in a way that he’d never typed before in “casual conversation”?",
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Maybe punish and set a predefined action with a bad deed point, of your perspective.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Situation 2",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Your “friend” redeemed himself for a past “screw up” by helping you without asking.",
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Maybe bless and set a predefined action with a good deed point, of your perspective.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "next-intro",
                child: Material(
                  type: MaterialType.transparency,
                  child: CarmaButton(
                    "Got it. Next?",
                    onTap: () {
                      Navigator.pushNamed(context, IntroStep3.ROUTE_NAME);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
