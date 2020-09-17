import 'package:carma/data/stances.dart';
import 'package:flutter/cupertino.dart';

class Entity {
  final String name;
  Karma karma;
  String currentJudgment;
  String initalReason;

  Entity(this.name, {@required this.karma, this.initalReason}) {
    this.currentJudgment = this.karma.judge();
  }
}
