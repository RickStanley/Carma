import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carma/data/deed.dart';
import 'package:carma/data/entity.dart';
import 'package:carma/data/routesArguments.dart';
import 'package:carma/data/karmas.dart';
import 'package:carma/main.dart';
import 'package:carma/newDeed.dart';
import 'package:carma/utils/carmaWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EntityEdit extends StatefulWidget {
  static const ROUTE_NAME = "/entity-edit";

  @override
  _EntityEditState createState() => _EntityEditState();
}

class _EntityEditState extends State<EntityEdit> {
  final goodKarmaEffect = AssetsAudioPlayer();
  final badKarmaEffect = AssetsAudioPlayer();

  @override
  void initState() {
    goodKarmaEffect.open(
      Audio("assets/effects/Ui_karma_up.ogg"),
      autoStart: false,
    );
    badKarmaEffect.open(
      Audio("assets/effects/Ui_karma_down.ogg"),
      autoStart: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    goodKarmaEffect.dispose();
    badKarmaEffect.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EntityEditArguments entityEditArguments =
        ModalRoute.of(context).settings.arguments;
    final entity = entityEditArguments.entity;
    final entityDeedsReversed = entity.deeds.reversed.toList();

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EntityCard(
                      entity,
                      featured: true,
                    ),
                    Visibility(
                      visible: entity.initialReason != null &&
                          entity.initialReason.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            "Initial stance",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(entity.initialReason),
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
                      // @todo Scroll top when new deed is added.
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              DeedCard(
                            deed: entityDeedsReversed[index],
                          ),
                          itemCount: entityDeedsReversed.length,
                        ),
                      )
                    else
                      Text("No deeds yet."),
                  ],
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                CarmaButton(
                  "Add deed",
                  onTap: () async {
                    final Deed deed = await deedsDialog(context, entity);
                    if (deed != null) {
                      if (deed.karmaType == KarmaType.Good) {
                        goodKarmaEffect.play();
                      } else {
                        badKarmaEffect.play();
                      }
                      setState(() {
                        entity.deeds.add(deed);
                      });
                    }
                  },
                ),
              ],
            ),
          ],
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
          var availableDeeds = [];
          Deed selectedDeed;

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
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
                                      selectedDeed = null;
                                      availableDeeds = List<Deed>.from(
                                          Deed.deedsCache.where((deed) {
                                        return deed.karmaType == selectedKarma;
                                      }));
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
                                            padding: const EdgeInsets.all(0.0),
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedDeed =
                                                      availableDeeds[index];
                                                });
                                              },
                                              child: DeedCard(
                                                deed: availableDeeds[index],
                                                color: selectedDeed ==
                                                        availableDeeds[index]
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.5)
                                                    : null,
                                              ),
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

                                                  if (deed != null &&
                                                      deed is Deed) {
                                                    Deed.deedsCache.add(deed);
                                                    Navigator.pop(
                                                      context,
                                                      deed,
                                                    );
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
                          buttonPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 10.0,
                          ),
                          mainAxisSize: MainAxisSize.max,
                          overflowDirection: VerticalDirection.up,
                          children: [
                            CarmaButton(
                              "Add deed",
                              disabled: selectedDeed == null,
                              onTap: () {
                                Navigator.pop(
                                  context,
                                  selectedDeed,
                                );
                              },
                            ),
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
