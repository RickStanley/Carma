import 'package:carma/data/deed.dart';
import 'package:carma/data/entity.dart';
import 'package:carma/data/routesArguments.dart';
import 'package:carma/data/stances.dart';
import 'package:carma/main.dart';
import 'package:carma/newDeed.dart';
import 'package:carma/utils/carmaWidgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EntityEdit extends StatefulWidget {
  static const ROUTE_NAME = "/entity-edit";

  @override
  _EntityEditState createState() => _EntityEditState();
}

class _EntityEditState extends State<EntityEdit> {
  @override
  Widget build(BuildContext context) {
    final EntityEditArguments entityEditArguments =
        ModalRoute.of(context).settings.arguments;
    final entity = entityEditArguments.entity;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      availableKarmas
                          .firstWhere(
                              (karmaCard) => karmaCard.karma == entity.karma)
                          .karmaIcon,
                      VerticalDivider(
                        width: 18.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entity.name,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            entity.currentJudgment,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      color: Color(0xff55585A),
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: entity.initalReason != null &&
                        entity.initalReason.isNotEmpty,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          "Initial stance",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(entity.initalReason),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Deeds",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  if (entity.deeds.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          DeedCard(
                        deed: entity.deeds[index],
                      ),
                      itemCount: entity.deeds.length,
                    )
                  else
                    Text("No deeds yet."),
                ],
              ),
              Positioned(
                bottom: 0,
                child: CarmaButton(
                  "Add deed",
                  onTap: () async {
                    final Deed deed = await deedsDialog(context, entity);
                    if (deed != null) {
                      setState(() {
                        entity.deeds.add(deed);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deedsDialog(BuildContext context, Entity entity) async {
    return await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          KarmaType selectedKarma;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              final availableDeeds = Deed.deedsCache
                  .where((deed) => deed.karmaType == selectedKarma)
                  .toList();


              return Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: SingleChildScrollView(
                          child: DefaultTextStyle(
                            style: Theme.of(context).textTheme.bodyText1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Deed type",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                RuleOfTwo(
                                  labelStyle:
                                      Theme.of(context).textTheme.headline4,
                                  notifier: (KarmaType newKarma) {
                                    setState(() {
                                      selectedKarma = newKarma;
                                    });
                                  },
                                  selectedKarma: selectedKarma,
                                ),
                                Visibility(
                                  visible: selectedKarma != null,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Select a deed",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                      if (availableDeeds.isNotEmpty)
                                        ConstrainedBox(
                                          constraints:
                                              BoxConstraints(maxHeight: 250.0),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                DeedCard(
                                              deed: availableDeeds[index],
                                            ),
                                            itemCount: availableDeeds.length,
                                          ),
                                        )
                                      else
                                        Text("No deed registered yet."),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Add a ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(color: DARK_COLOR),
                                          children: [
                                            TextSpan(
                                              text: "new deed →",
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  final deed =
                                                      await Navigator.pushNamed(
                                                    context,
                                                    NewDeed.ROUTE_NAME,
                                                    arguments: NewDeedArguments(
                                                      karmaType: selectedKarma,
                                                    ),
                                                  );

                                                  if (deed != null && deed is Deed) {
                                                    Navigator.pop(
                                                        context, deed);
                                                  }
                                                },
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: ButtonBar(
                          buttonPadding: const EdgeInsets.all(0),
                          mainAxisSize: MainAxisSize.max,
                          overflowDirection: VerticalDirection.up,
                          children: [
                            CarmaButton(
                              "Cancel",
                              outline: true,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
