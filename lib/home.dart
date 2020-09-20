import 'package:carma/data/entity.dart';
import 'package:carma/data/routesArguments.dart';
import 'package:carma/entityEdit.dart';
import 'package:carma/entitySetup.dart';
import 'package:carma/utils/carmaWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:assets_audio_player/assets_audio_player.dart";

class Home extends StatefulWidget {
  static const ROUTE_NAME = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final gavelAudioEffect = AssetsAudioPlayer();

  List<Entity> _entities = [];

  @override
  void initState() {
    gavelAudioEffect.open(
      Audio("assets/effects/gavel.ogg"),
      autoStart: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final currentEntity = _entities[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      EntityEdit.ROUTE_NAME,
                      arguments: EntityEditArguments(
                        currentEntity,
                      ),
                    );
                  },
                  child: EntityCard(currentEntity),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.transparent,
                  height: 10.0,
                );
              },
              itemCount: _entities.length,
            ),
            Visibility(
              visible: _entities.length != 0,
              child: Divider(
                height: 10.0,
              ),
            ),
            GestureDetector(
              onTap: () async {
                KingsJusticeResult veredict = await _kingsJustice(context);
                if (veredict != null) {
                  gavelAudioEffect.play();
                  print(
                      "Karma: ${veredict.karma.typeName} | Entity name: ${veredict.entityName}");
                  setState(() {
                    _entities.add(Entity(
                      veredict.entityName,
                      karma: veredict.karma,
                      initialReason: veredict.reason,
                    ));
                  });
                }
              },
              child: EntityCardEmpty(),
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
