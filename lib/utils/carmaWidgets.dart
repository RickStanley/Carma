import 'package:carma/data/deed.dart';
import 'package:carma/data/stances.dart';
import 'package:carma/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarmaButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool outline;
  final bool disabled;

  const CarmaButton(this.text,
      {Key key, this.onTap, this.outline = false, this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Container(
      decoration: BoxDecoration(
          color: this.outline
              ? Colors.transparent
              : Theme.of(context).primaryColor,
          border: this.outline
              ? Border.all(
                  color: Theme.of(context).primaryColor,
                )
              : null),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: DARK_COLOR,
        ),
      ),
    );
    return this.disabled
        ? Opacity(
            opacity: 0.3,
            child: content,
          )
        : GestureDetector(
            onTap: this.onTap,
            child: content,
          );
  }
}

class EntityCard extends StatelessWidget {
  final String name;
  final String currentJudgment;
  final Image icon;
  final void Function() onMore;

  const EntityCard({
    Key key,
    @required this.name,
    @required this.currentJudgment,
    @required this.icon,
    this.onMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 7,
      ),
      color: Color(0xfff5f5f5),
      child: Row(
        children: [
          Hero(
            tag: this.name.replaceAll(RegExp(" +"), "_"),
            child: icon,
          ),
          SizedBox(
            width: 11,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                currentJudgment,
                style: TextStyle(
                  color: Color(0xff55585A),
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: onMore,
            child: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}

// @todo Merge layout of "EntityType" and "EntityEmpty" with "EntityCard"
class EntityCardEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 7),
      color: Color(0xfff5f5f5),
      child: Row(
        children: [
          // @todo Change to Carma Icons
          Hero(
            tag: "entity-icon",
            child: Icon(
              Icons.account_circle,
              size: 50,
              color: Color(0xff212121),
            ),
          ),
          SizedBox(
            width: 11,
          ),
          Text(
            'New entity',
            style: Theme.of(context).textTheme.headline3,
          ),
          Spacer(),
          Icon(
            Icons.add_circle_outline,
            size: 35,
          )
        ],
      ),
    );
  }
}

// @todo Merge layout of "EntityType" and "EntityEmpty" with "EntityCard"
class EntityCardType extends StatelessWidget {
  final Image karmaIcon;
  final Karma karma;

  const EntityCardType({
    Key key,
    @required this.karmaIcon,
    @required this.karma,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        karmaIcon,
        SizedBox(
          width: 18,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.karma.typeName,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              this.karma.description,
              style: TextStyle(
                color: Color(0xff55585A),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

var availableKarmas = List<EntityCardType>.unmodifiable([
  for (var carma in karmas)
    EntityCardType(
      karmaIcon:
          Image.asset("assets/karmas/${carma.typeName.toLowerCase()}.webp"),
      karma: carma,
    )
]);

class IntroTitle extends StatelessWidget {
  final int stepNumber;
  final String stepTitle;

  const IntroTitle({Key key, this.stepNumber, this.stepTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Positioned(
          left: 0,
          bottom: -10,
          child: Opacity(
            opacity: .5,
            child: Text(
              "$stepNumber.",
              style: TextStyle(
                color: DA_COLOR,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Text(
          stepTitle,
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}

class CarmaIntroAppBar extends AppBar {
  final int stepNumber;
  final String stepTitle;

  CarmaIntroAppBar({
    this.stepNumber,
    this.stepTitle,
  }) : super(
          elevation: 0,
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            title: IntroTitle(
              stepNumber: stepNumber,
              stepTitle: stepTitle,
            ),
          ),
        );
}

class RuleOfTwo extends StatelessWidget {
  final Size iconSize;
  final double gapSize;
  final TextStyle labelStyle;
  final Function(KarmaType) notifier;
  final KarmaType selectedKarma;

  const RuleOfTwo(
      {Key key,
      this.iconSize,
      this.gapSize = 50,
      this.labelStyle,
      this.notifier,
      this.selectedKarma})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = labelStyle ?? Theme.of(context).textTheme.headline2;
    final hasNotifier = this.notifier != null;

    final goodColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/karmas/good.webp",
          width: iconSize?.width,
          height: iconSize?.height,
          fit: BoxFit.contain,
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          "Good Karma",
          style: style,
        ),
      ],
    );

    final evilColumn = Column(
      children: [
        Image.asset(
          "assets/karmas/evil.webp",
          width: iconSize?.width,
          height: iconSize?.height,
          fit: BoxFit.contain,
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          "Evil Karma",
          style: style,
        ),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        hasNotifier
            ? GestureDetector(
                onTap: () {
                  notifier(KarmaType.Good);
                },
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  color: selectedKarma == KarmaType.Good
                      ? Theme.of(context).primaryColor.withOpacity(0.5)
                      : Colors.transparent,
                  child: goodColumn,
                ),
              )
            : goodColumn,
         VerticalDivider(
          width: this.gapSize,
        ),
        hasNotifier
            ? GestureDetector(
                onTap: () {
                  notifier(KarmaType.Evil);
                },
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  color: selectedKarma == KarmaType.Evil
                      ? Theme.of(context).primaryColor.withOpacity(0.5)
                      : Colors.transparent,
                  child: evilColumn,
                ),
              )
            : evilColumn,
      ],
    );
  }
}

class DeedCard extends StatelessWidget {
  final Deed deed;

  const DeedCard({Key key, this.deed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = deed.karmaType == KarmaType.Evil
        ? 0xffD04747
        : 0xff69DA4C;

    return Row(
      children: [
        Text(
          deed.description,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          deed.formattedPoints,
          style: TextStyle(
            color: Color(color),
          ),
        ),
      ],
    );
  }
}
