import 'package:carma/data/deed.dart';
import 'package:carma/data/entity.dart';
import 'package:carma/data/karmas.dart';
import 'package:carma/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarmaButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool outline;
  final bool disabled;

  const CarmaButton(
    this.text, {
    Key key,
    this.onTap,
    this.outline = false,
    this.disabled = false,
  }) : super(key: key);

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
  final Entity entity;
  final void Function() trailingTap;
  final bool featured;
  final Icon trailingIcon;

  const EntityCard(
    this.entity, {
    Key key,
    this.featured = false,
    this.trailingTap,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context).textTheme;

    final padding = featured
        ? null
        : const EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 7,
          );
    final bgColor = featured ? Colors.transparent : Color(0xfff5f5f5);
    final spaceBetweenTitles = featured ? 11.0 : 18.0;
    final nameStyle =
        featured ? currentTheme.headline1 : currentTheme.headline3;
    final judgmentStyle = featured
        ? currentTheme.headline4.copyWith(
            color: Color(0xff55585A),
            fontWeight: FontWeight.normal,
          )
        : TextStyle(
            color: Color(0xff55585A),
          );
    final icon = SvgPicture.asset(
      "assets/karmas/${entity.karma.karmaStatus.prime.name}.svg",
      width: featured ? 50.0 : 39.0,
      height: featured ? 67.72 : 52.82,
    );
    return Container(
      padding: padding,
      color: bgColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            // @todo Maybe this will fail at some point, because hashCode is not reliable to be unique
            tag: entity.hashCode.toString(),
            child: icon,
          ),
          VerticalDivider(
            width: spaceBetweenTitles,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entity.name,
                  style: nameStyle,
                ),
                Text(
                  entity.karma.currentJudgment,
                  style: judgmentStyle,
                ),
              ],
            ),
          ),
          if (trailingIcon != null)
            GestureDetector(
              onTap: trailingTap,
              child: trailingIcon,
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
          Hero(
            tag: "entity-icon",
            child: SvgPicture.asset(
              "assets/generic_icons/selection_user.svg",
              width: 39.0,
              height: 39.0,
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
  final SvgPicture karmaIcon;
  final KarmaStatus karmaStatus;

  const EntityCardType({
    Key key,
    @required this.karmaIcon,
    @required this.karmaStatus,
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
              this.karmaStatus.name,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              this.karmaStatus.description,
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
  for (var karmaType in KarmaStatusCore.primeKarmas)
    EntityCardType(
      karmaIcon: SvgPicture.asset(
        "assets/karmas/${karmaType.name}.svg",
        width: 39.0,
        height: 52.82,
      ),
      karmaStatus: karmaType,
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
  final Function(KarmaStatus) notifier;
  final KarmaStatus selectedKarma;

  const RuleOfTwo({
    Key key,
    this.iconSize,
    this.gapSize = 50,
    this.labelStyle,
    this.notifier,
    this.selectedKarma,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = labelStyle ?? Theme.of(context).textTheme.headline2;
    final hasNotifier = this.notifier != null;

    final goodColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/karmas/Good.svg",
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
        SvgPicture.asset(
          "assets/karmas/Evil.svg",
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
                  notifier(KarmaStatus.Good);
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  color: selectedKarma == KarmaStatus.Good
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
                  notifier(KarmaStatus.Evil);
                },
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  color: selectedKarma == KarmaStatus.Evil
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
  final Color color;

  const DeedCard({
    Key key,
    @required this.deed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pointsColor = deed.karmaStatus == KarmaStatus.Evil
        ? Color(0xffD04747)
        : Color(0xff008028);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      color: color ?? Color(0xfff5f5f5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              deed.description,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text(
            deed.formattedPoints,
            style: TextStyle(
              color: pointsColor,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
