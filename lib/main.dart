import 'dart:math';

import 'package:flutter/material.dart';

MyTheme currentTheme = MyTheme();

void main() {
  return runApp(MyApp());
}

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.blueAccent[200],
        fontFamily: 'Montserrat', //3
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.purple[100],
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: Colors.grey[800],
        scaffoldBackgroundColor: Colors.black54,
        fontFamily: 'Montserrat',
        textTheme: ThemeData.dark().textTheme,
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.purple[100],
        ));
  }
}

class MyTheme with ChangeNotifier {
  static bool _isDark = true;
  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme(),
      home: Scaffold(
          //backgroundColor: Colors.red,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.brightness_high),
              onPressed: () {
                currentTheme.switchTheme();
              },
            ),
            centerTitle: true,
            title: Text('Dice'),
            //backgroundColor: Theme.of(context).accentColor,
          ),
          body: DicePage()),
    );
  }
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  //int dice1 = 2;
  //int dice2 = 1;
  List<int> die = [2, 1];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(die.length, (index) {
          var dice = die[index];
          return Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  rollDice();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('images/dice$dice.png', height: 150.0),
                    ShadedBox()
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void rollDice() {
    setState(() {
      die = [Random().nextInt(6) + 1, Random().nextInt(6) + 1];
    });
  }
}

class ShadedBox extends StatelessWidget {
  const ShadedBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: MyTheme._isDark ? 0.5 : 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        width: 151.0,
        height: 151.0,
      ),
    );
  }
}
