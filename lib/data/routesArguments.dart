import 'package:carma/data/entity.dart';

import 'karmas.dart';

class KingsJusticeResult {
  final KarmaStatus karmaStatus;
  final String entityName;
  final String reason;

  const KingsJusticeResult(this.karmaStatus, this.entityName, this.reason);
}

class EntityEditArguments {
  final Entity entity;

  const EntityEditArguments(this.entity);
}

class NewDeedArguments {
  final KarmaStatus karmaStatus;

  const NewDeedArguments({this.karmaStatus});
}
