import 'package:carma/data/deed.dart';
import 'package:carma/data/karmas.dart';
import 'package:flutter/foundation.dart';

class Entity {
  final String name;
  Karma karma;
  String currentJudgment;
  String initialReason;
  List<Deed> deeds = [];

  Entity(this.name, {@required this.karma, this.initialReason}) {
    this.currentJudgment = this.karma.judge();
  }
}
