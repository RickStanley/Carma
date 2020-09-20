import 'package:carma/data/entity.dart';

class Globals {
  static List<Entity> entities = [];

  static final Globals _singleton = Globals._internal();

  factory Globals() {
    return _singleton;
  }

  Globals._internal();
}
