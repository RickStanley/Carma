import 'package:carma/data/stances.dart';
import 'package:carma/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarmaButton extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const CarmaButton(this.text, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        child: Text(
          this.text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: DARK_COLOR,
          ),
        ),
      ),
    );
  }
}

class EntityEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 7),
      color: Color(0xfff5f5f5),
      child: Row(
        children: [
          // @todo Change to Carma Icons
          Icon(
            Icons.account_circle,
            size: 50,
            color: Color(0xff212121),
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
            color: Color(0xff212121),
          )
        ],
      ),
    );
  }
}

class EntityType extends StatelessWidget {
  final Image entityIcon;
  final Karma karma;

  const EntityType({
    Key key,
    @required this.entityIcon,
    @required this.karma,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        entityIcon,
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

var availableKarmas = List<EntityType>.unmodifiable([
  for (var carma in karmas)
    EntityType(
      entityIcon:
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
