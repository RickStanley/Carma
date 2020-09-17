import 'package:flutter/cupertino.dart';

enum KarmaType { Good, Neutral, Evil }

class Karma {
  final String typeName;
  final KarmaType type;
  final List<String> titles;
  final String description;

  const Karma(
    this.typeName, {
    @required this.type,
    @required this.description,
    @required this.titles,
  });
}

const karmas = [
  // Is const redundant?
  const Karma(
    "Good",
    type: KarmaType.Good,
    titles: [
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
    ],
    description: "Worthy of your attention.",
  ),
  const Karma(
    "Neutral",
    type: KarmaType.Neutral,
    titles: [
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
    ],
    description: "This person is yet to be judged.",
  ),
  const Karma(
    "Evil",
    type: KarmaType.Evil,
    titles: [
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
    ],
    description: "Non-reliable person.",
  ),
];
