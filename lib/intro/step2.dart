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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(alignment: Alignment.center, children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/karmas/good.webp",
                          width: 100.0,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Good Karma",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    VerticalDivider(
                      width: 50,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          "assets/karmas/evil.webp",
                          width: 100.0,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Evil Karma",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 23.0,
                ),
                Text(
                  "Situtation 1",
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
                  "Situtation 1",
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
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            child: Hero(
              tag: "next-intro",
              transitionOnUserGestures: true,
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
          ),
        ]),
      ),
    );
  }
}
