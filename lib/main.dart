import 'package:flutter/material.dart';
import 'package:footapp/provider/Teams.dart';
import 'package:footapp/provider/loading.dart';
import 'package:footapp/provider/selectPlayer.dart';
import 'package:footapp/style/Mytheme.dart';
import 'package:provider/provider.dart';
import 'Screens/homeScreen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoadingControl>(
          create: (context) => LoadingControl()),
      ChangeNotifierProvider<SelectPlayerProvider>(
          create: (context) => SelectPlayerProvider()),
      ChangeNotifierProvider<SelectTeamProvider>(
          create: (context) => SelectTeamProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foot Application',
      theme: myTheme,
      home: MyHomePage(),
    );
  }
}
