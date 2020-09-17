import 'package:carma/data/routesArguments.dart';
import 'package:carma/entity_setup/setup.dart';
import 'package:carma/utils/carmaWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:assets_audio_player/assets_audio_player.dart";

class Home extends StatelessWidget {
  static const ROUTE_NAME = "/home";
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    assetsAudioPlayer.open(
      Audio("assets/effects/gavel.ogg"),
      autoStart: false,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Hero(
          tag: "the-title",
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              "Carma",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                KingsJusticeResult veredict = await _kingsJustice(context);
                if (veredict != null) {
                  assetsAudioPlayer.play();
                  print(
                      "Karma: ${veredict.karma.typeName} | Entity name: ${veredict.entityName}");
                }
              },
              child: EntityEmpty(),
            ),
          ],
        ),
      ),
    );
  }

  _kingsJustice(BuildContext context) async {
    return await Navigator.pushNamed(context, EntitySetup.ROUTE_NAME);
  }
}
