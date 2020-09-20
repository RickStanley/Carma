import 'package:carma/data/entity.dart';
import 'package:carma/data/karmas.dart';
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
                    EntityCardEmpty(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "What is entity?",
                      style: Theme.of(context).textTheme.headline4,
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
                    Text(
                      "1.1 Give this entity a name.",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                        "Any name you want. Adolf Schlinder, Mal'Ganis, Robert Baratheon, Garry..."),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "1.2 Define its initial stance towards you.",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(
                      height: 5,
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
                    Text(
                        "After the setup, the entity will be given a random title, according to its initial stance.\nFor example:"),
                    SizedBox(
                      height: 5.0,
                    ),
                    EntityCard(
                      Entity(
                        "Julius Caesar",
                        initialKarma: KarmaStatus.Good,
                      ),
                    )
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
                      Navigator.pushNamed(context, IntroStep2.ROUTE_NAME);
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
