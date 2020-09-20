import 'package:carma/data/routesArguments.dart';
import 'package:carma/data/karmas.dart';
import 'package:carma/main.dart';
import 'package:carma/utils/carmaWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntitySetup extends StatefulWidget {
  static const ROUTE_NAME = "/new-entity";

  @override
  _EntitySetupState createState() => _EntitySetupState();
}

class _EntitySetupState extends State<EntitySetup> {
  final _textFieldFocus = FocusNode();
  final _entityNameController = TextEditingController();
  final _reasonTextController = TextEditingController();

  bool _validateName = false;
  bool _validateEntityType = false;
  Karma _selectedKarma;
  int _textFieldHeight = 1;

  String heroTag;

  @override
  void initState() {
    super.initState();
    _textFieldFocus.addListener(() {
      setState(() {
        _textFieldHeight = _textFieldFocus.hasFocus ? 5 : 1;
      });
    });
    _entityNameController.addListener(() {
      setState(() {
        _validateName = _entityNameController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _entityNameController.dispose();
    _reasonTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: heroTag ?? "entity-icon",
                          child: _selectedKarma != null
                              ? availableKarmas
                                  .firstWhere(
                                    (karmaCard) =>
                                        karmaCard.karma == _selectedKarma,
                                  )
                                  .karmaIcon
                              : SvgPicture.asset(
                                  "assets/generic_icons/selection_user.svg",
                                  width: 50.0,
                                  height: 50.0,
                                ),
                        ),
                        VerticalDivider(
                          width: 18.0,
                        ),
                        Expanded(
                          child: TextField(
                            autocorrect: false,
                            controller: _entityNameController,
                            enableSuggestions: false,
                            textCapitalization: TextCapitalization.sentences,
                            autofillHints: null,
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Insert entity name",
                              errorText: _validateName
                                  ? "Please enter the entity name."
                                  : null,
                              hintStyle: TextStyle(
                                color: Color(0xFF55585A),
                                fontSize: 24.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 21.0,
                    ),
                    Text(
                      "Current stance",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () => {
                          setState(() {
                            _selectedKarma = availableKarmas[index].karma;
                            _validateEntityType = false;
                          })
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          color: _selectedKarma == availableKarmas[index].karma
                              ? DA_COLOR.withOpacity(0.4)
                              : Colors.transparent,
                          child: availableKarmas[index],
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 9,
                        color: Colors.transparent,
                      ),
                      itemCount: availableKarmas.length,
                    ),
                    Visibility(
                      visible: _validateEntityType,
                      child: Text(
                        "Please select an entity.",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(
                              color: Theme.of(context).errorColor,
                            )
                            .merge(
                              Theme.of(context).inputDecorationTheme.errorStyle,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    Visibility(
                      visible: _selectedKarma?.type == KarmaType.Good ||
                          _selectedKarma?.type == KarmaType.Evil,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reason?",
                            style: TextStyle(
                              color: DARK_COLOR,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Care to explain why this entity is ",
                              children: [
                                TextSpan(
                                  text: _selectedKarma?.typeName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: "?")
                              ],
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xff636769),
                              ),
                            ),
                          ),
                          TextField(
                            focusNode: _textFieldFocus,
                            maxLines: _textFieldHeight,
                            controller: _reasonTextController,
                            maxLengthEnforced: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xfff5f5f5),
                              hintText: "The reason(s) here...",
                              border: _textFieldFocus.hasFocus
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    )
                                  : InputBorder.none,
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                CarmaButton(
                  "Done",
                  onTap: () {
                    if (_entityNameController.text.isEmpty ||
                        _selectedKarma == null) {
                      setState(() {
                        _validateName = _entityNameController.text.isEmpty;
                        _validateEntityType = _selectedKarma == null;
                      });
                    } else {
                      setState(() {
                        heroTag = _entityNameController.text
                            .replaceAll(RegExp(" +"), "_");
                      });
                      Navigator.pop(
                        context,
                        KingsJusticeResult(
                          _selectedKarma,
                          _entityNameController.text.trim(),
                          _reasonTextController.text.trim(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
