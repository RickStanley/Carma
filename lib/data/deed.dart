import 'package:carma/data/stances.dart';

class Deed {
  final KarmaType karmaType;
  final String description;
  final int points;
  static List<Deed> deedsCache = [];

  const Deed(this.karmaType, this.description, this.points);

  get formattedPoints {
    return "${karmaType == KarmaType.Good ? "+" : "-"}$points";
  }
}