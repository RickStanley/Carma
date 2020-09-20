import 'package:carma/data/deed.dart';
import 'package:carma/data/karmas.dart';
import 'package:flutter/foundation.dart';

class Entity {
  final String name;
  final String initialReason;
  Karma karma;
  List<Deed> deeds = [];

  Entity(
    this.name, {
    @required KarmaStatus initialKarma,
    this.initialReason,
  }) : this.karma = Karma(karmaStatus: initialKarma);

  addDeedAndUpdateKarma(Deed deed) {
    deeds.add(deed);
    karma.points = deed.points;
  }
}
