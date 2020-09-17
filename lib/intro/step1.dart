import 'package:carma/intro/step2.dart';
import 'package:carma/utils/carmaWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IntroStep1 extends StatelessWidget {
  static const ROUTE_NAME = "/intro/step/1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CarmaIntroAppBar(
        stepNumber: 1,
        stepTitle: "Create an entity.",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(alignment: Alignment.center, children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EntityEmpty(),
                SizedBox(
                  height: 26,
                ),
                Text(
                  "What is entity?",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "It can be a friend, the boss, your girl-or-boyfriend, a rock... Anything. An entity.",
                ),
                SizedBox(
                  height: 14,
                ),
                Text("Define his/her/its initial stance towards you:"),
                SizedBox(
                  height: 12,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      availableKarmas[index],
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  itemCount: availableKarmas.length,
                ),
                SizedBox(
                  height: 22,
                ),
                EntityEmpty(),
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
                    Navigator.pushNamed(context, IntroStep2.ROUTE_NAME);
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
