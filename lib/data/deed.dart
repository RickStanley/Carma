import 'package:carma/data/karmas.dart';
import 'package:quiver/core.dart' show hash3;

class Deed {
  final KarmaStatus karmaStatus;
  final String description;
  final int points;
  static Set<Deed> deedsCache = Set();

  const Deed(this.karmaStatus, this.description, this.points);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Deed &&
        karmaStatus == other.karmaStatus &&
        description == other.description &&
        points == other.points;
  }

  get formattedPoints {
    return "${karmaStatus == KarmaStatus.Good ? "+" : "-"}$points";
  }

  @override
  int get hashCode => hash3(description, KarmaStatus, points);
}
