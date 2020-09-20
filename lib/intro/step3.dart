import 'package:carma/home.dart';
import 'package:carma/utils/carmaWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IntroStep3 extends StatelessWidget {
  static const ROUTE_NAME = "/intro/step/3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CarmaIntroAppBar(
        stepNumber: 3,
        stepTitle: "Let their actions define who they are.",
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
                    Text(
                      "From the perspective of the creator of this app, we are whom our actions define us.",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Words don’t mean nothing if they aren’t honoured.",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Broken promises build up to bad reputation and lack of respect.",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Sometimes it’s hardly our position to judge one’s action through sheer hate or blind sympathy. We ought be careful not to let our emotions cloud our judgements.",
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
                    "Neither disagree nor agree - Proceed",
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Home.ROUTE_NAME,
                        ModalRoute.withName("/"),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
