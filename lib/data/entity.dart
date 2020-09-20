import 'package:carma/data/deed.dart';
import 'package:carma/data/karmas.dart';
import 'package:flutter/foundation.dart';

class Entity {
  final String name;
  final String initialReason;
  Karma karma;
  String currentJudgment;
  List<Deed> deeds = [];

  Entity(this.name, {@required KarmaStatus initialKarma, this.initialReason}) {
    this.karma = Karma(karmaStatus: initialKarma);
    this.currentJudgment = this.karma.judge();
  }
}
