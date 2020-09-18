import 'package:carma/data/entity.dart';

import 'stances.dart';

class KingsJusticeResult {
  final Karma karma;
  final String entityName;
  final String reason;

  const KingsJusticeResult(this.karma, this.entityName, this.reason);
}

class EntityEditArguments {
  final Entity entity;

  const EntityEditArguments(this.entity);
}

class NewDeedArguments {
  final KarmaType karmaType;

  const NewDeedArguments({this.karmaType});
}
