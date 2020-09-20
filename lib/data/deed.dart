import 'package:carma/data/karmas.dart';
import 'package:quiver/core.dart' show hash3;

class Deed {
  final KarmaType karmaType;
  final String description;
  final int points;
  static Set<Deed> deedsCache = Set();

  const Deed(this.karmaType, this.description, this.points);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Deed &&
        karmaType == other.karmaType &&
        description == other.description &&
        points == other.points;
  }

  get formattedPoints {
    return "${karmaType == KarmaType.Good ? "+" : "-"}$points";
  }

  @override
  int get hashCode => hash3(description, karmaType, points);
}
