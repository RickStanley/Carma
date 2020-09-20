import 'package:carma/data/deed.dart';
import 'package:carma/data/routesArguments.dart';
import 'package:carma/main.dart';
import 'package:carma/utils/carmaWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spinner_input/spinner_input.dart';

import 'data/karmas.dart';

class NewDeed extends StatefulWidget {
  static const ROUTE_NAME = "/new-deed";

  @override
  _NewDeedState createState() => _NewDeedState();
}

class _NewDeedState extends State<NewDeed> {
  final _textFieldFocus = FocusNode();
  final _textFieldController = TextEditingController();

  bool _validateReason = false;
  double spinnerValue = 1.0;
  KarmaType selectedKarma;
  Color deedColor;

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NewDeedArguments arguments =
        ModalRoute.of(context).settings.arguments;

    selectedKarma ??= arguments.karmaType;

    deedColor = selectedKarma == KarmaType.Evil
        ? Color(0xffD04747)
        : Color(0xff008028);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          "New deed",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deed type",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RuleOfTwo(
                    labelStyle: Theme.of(context).textTheme.headline4,
                    notifier: (KarmaType newKarma) {
                      setState(() {
                        selectedKarma = newKarma;
                      });
                    },
                    selectedKarma: selectedKarma,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Points",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      VerticalDivider(
                        width: 10.0,
                      ),
                      SpinnerInput(
                        spinnerValue: spinnerValue,
                        minValue: 1,
                        middleNumberPadding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 0.0,
                        ),
                        maxValue: 1000,
                        direction: TextDirection.rtl,
                        popupButton: SpinnerButtonStyle(
                          color: Theme.of(context).primaryColor,
                          textColor: DARK_COLOR,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        popupTextStyle: TextStyle(
                          fontSize: 35,
                        ),
                        minusButton: SpinnerButtonStyle(
                          elevation: 0,
                          color: Theme.of(context).primaryColor,
                          textColor: DARK_COLOR,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        plusButton: SpinnerButtonStyle(
                          elevation: 0,
                          color: Theme.of(context).primaryColor,
                          textColor: DARK_COLOR,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        middleNumberStyle: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        onChange: (newValue) {
                          setState(() {
                            spinnerValue = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1,
                      text: "The weight of this ",
                      children: [
                        TextSpan(
                          text: selectedKarma == KarmaType.Good
                              ? "bless"
                              : "treason",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: deedColor,
                          ),
                        ),
                        TextSpan(text: " will be "),
                        TextSpan(
                          text: spinnerValue.toStringAsFixed(0),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: deedColor
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "What ${selectedKarma == KarmaType.Good ? "bless" : "treachery"} is this?",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    maxLines: 2,
                    maxLength: 69,
                    controller: _textFieldController,
                    focusNode: _textFieldFocus,
                    maxLengthEnforced: true,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xfff5f5f5),
                      hintText: "Deed description",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      errorText:
                          _validateReason ? "Please enter the reason." : null,
                      border: InputBorder.none,
                    ),
                  ),
                  Text(
                      "Hint: use a generic deed description so you can re-use it later."),
                ],
              ),
            ),
          ),
          ButtonBar(
            children: [
              CarmaButton(
                "Add ${selectedKarma == KarmaType.Good ? "bless" : "treason"}",
                onTap: () {
                  if (_textFieldController.text.isEmpty) {
                    setState(() {
                      _validateReason = true;
                    });
                  } else {
                    Navigator.pop(
                      context,
                      Deed(
                        selectedKarma,
                        _textFieldController.text.trim(),
                        spinnerValue.toInt(),
                      ),
                    );
                  }
                },
              ),
              CarmaButton(
                "Cancel",
                outline: true,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
