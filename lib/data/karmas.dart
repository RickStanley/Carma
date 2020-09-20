import 'dart:math';

import 'package:flutter/foundation.dart';

enum KarmaStatus { VeryGood, Good, Neutral, Evil, VeryEvil }

extension KarmaStatusCore on KarmaStatus {
  static List<KarmaStatus> get primeKarmas =>
      [KarmaStatus.Good, KarmaStatus.Neutral, KarmaStatus.Evil];

  KarmaStatus get prime {
    switch (this) {
      case KarmaStatus.VeryGood:
      case KarmaStatus.Good:
        return KarmaStatus.Good;
        break;
      case KarmaStatus.Neutral:
        return KarmaStatus.Neutral;
      case KarmaStatus.Evil:
      case KarmaStatus.VeryEvil:
        return KarmaStatus.Evil;
      default:
        return null;
    }
  }

  String get description {
    switch (this) {
      case KarmaStatus.VeryGood:
      case KarmaStatus.Good:
        return "Worthy of your attention.";
        break;
      case KarmaStatus.Neutral:
        return "This person is yet to be judged.";
      case KarmaStatus.Evil:
      case KarmaStatus.VeryEvil:
        return "Non-reliable person.";
      default:
        return null;
    }
  }

  // KarmaStatus.VeryGood -> [KarmaStatus, VeryGood] -> [Very, Good] -> "Very Good"
  String get name =>
      this.toString().split(".").last.split(RegExp("(?=[A-Z])")).join(" ");

  List<String> get titles {
    switch (this) {
      case KarmaStatus.VeryGood:
      case KarmaStatus.Good:
        return [
          "Samaritan",
          "Martyr",
          "Sentinel",
          "Defender",
          "Dignitary",
          "Peacekeeper",
          "Ranger of the Wastes",
          "Protector",
          "Desert Avenger",
          "Exemplar",
          "Vegas Crusader",
          "Paladin",
          "Mojave Legend",
          "Shield of Hope",
          "Vegas Legend",
          "Hero of the Wastes",
          "Paragon",
          "Wasteland Savior",
          "Saint",
          "Guardian of the Wastes",
          "Restorer of Faith",
          "Model of Selflessness",
          "Shepherd",
          "Friend of the People",
          "Champion of Justice",
          "Symbol of Order",
          "Herald of Tranquility",
          "Last, Best Hope of Humanity",
          "Savior of the Damned",
          "Messiah"
        ];
        break;
      case KarmaStatus.Neutral:
        return [
          "Drifter",
          "Renegade",
          "Seeker",
          "Wanderer",
          "Citizen",
          "Adventurer",
          "Vagabond of the Wastes",
          "Mercenary",
          "Desert Scavenger",
          "Observer",
          "Vegas Councilor",
          "Keeper",
          "Mojave Myth",
          "Pinnacle of Survival",
          "Vegas Myth",
          "Strider of the Wastes",
          "Beholder",
          "Wasteland Watcher",
          "Super-Human",
          "Renegade of the Wastes",
          "Soldier of Fortune",
          "Profiteer",
          "Egocentric",
          "Loner",
          "Hero for Hire",
          "Model of Apathy",
          "Person of Refinement",
          "Moneygrubber",
          "Gray Stranger",
          "True Mortal"
        ];
        break;
      case KarmaStatus.Evil:
      case KarmaStatus.VeryEvil:
        return [
          "Grifter",
          "Outlaw",
          "Opportunist",
          "Plunderer",
          "Fat Cat",
          "Marauder",
          "Pirate of the Wastes",
          "Betrayer",
          "Desert Terror",
          "Ne'er-do-well",
          "Vegas Crime lord",
          "Defiler",
          "Mojave Boogeyman",
          "Sword of Despair",
          "Vegas Boogeyman",
          "Villain of the Wastes",
          "Fiend",
          "Wasteland Destroyer",
          "Evil Incarnate",
          "Scourge of the Wastes",
          "Architect of Doom",
          "Bringer of Sorrow",
          "Deceiver",
          "Consort of Discord",
          "Stuff of Nightmares",
          "Agent of Chaos",
          "Instrument of Ruin",
          "Soultaker",
          "Demon's Spawn",
          "Devil"
        ];
        break;
      default:
        return null;
    }
  }
}

// @todo implement Karma status meter
class Karma {
  final KarmaStatus karmaStatus;

  const Karma({
    @required this.karmaStatus,
  });

  judge() => karmaStatus.titles[Random().nextInt(karmaStatus.titles.length)];
}
