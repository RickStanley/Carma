import 'package:carma/start.dart';
import 'package:carma/home.dart';
import 'package:carma/intro/step2.dart';
import 'package:carma/intro/step1.dart';
import 'package:carma/intro/step3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const DA_COLOR = Color(0xFFFFCB47);
const DARK_COLOR = Color(0xFF2B2B2B);

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
  runApp(CarmaApp());
}

class CarmaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carma',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: createMaterialColor(DA_COLOR),
        iconTheme: IconThemeData(color: DA_COLOR),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: DARK_COLOR,
          ),
          headline2: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: DARK_COLOR,
          ),
          headline3: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: DARK_COLOR,
          ),
          bodyText1: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF55585A),
            fontWeight: FontWeight.normal,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF55585A),
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      initialRoute: Start.ROUTE_NAME,
      routes: {
        Start.ROUTE_NAME: (context) => Start(),
        IntroStep1.ROUTE_NAME: (context) => IntroStep1(),
        IntroStep2.ROUTE_NAME: (context) => IntroStep2(),
        IntroStep3.ROUTE_NAME: (context) => IntroStep3(),
        Home.ROUTE_NAME: (context) => Home(),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
