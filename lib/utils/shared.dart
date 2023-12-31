// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:world/about_me.dart';
import 'package:world/game_model.dart';
import 'package:world/history.dart';

String theme = "dark";
String language = "en";
final List<String> supportedLanguages = <String>["EN", "FR", "AR"];
const String gameTitle = "WORLD";
final List<List<dynamic>> gameLetters = gameTitle.split(r"").map((String e) => <dynamic>[e, white]).toList();

const Color blue = Color.fromARGB(255, 0, 146, 175);
const Color white = Color.fromARGB(255, 229, 229, 229);
const Color transparent = Colors.transparent;
const Color green = Colors.green;
const Color red = Colors.red;
const Color dark = Colors.black87;
Color yellow = Colors.amber;

int cellsSize = 5;

Set<String> keyState = <String>{"CORRECT", "INCORRECT", "MISPLACED", "UNSELECTED"};

String selectedItem = "Home";

final List<Map<String, dynamic>> menu = <Map<String, dynamic>>[
  <String, dynamic>{"state": false, "item": "History", "onTap": () {}, "icon": FontAwesomeIcons.clockRotateLeft, "screen": const History()},
  <String, dynamic>{"state": false, "item": "Analytics", "onTap": () {}, "icon": FontAwesomeIcons.calculator, "screen": const History()},
  <String, dynamic>{"state": false, "item": "About Me", "onTap": () {}, "icon": FontAwesomeIcons.medal, "screen": const AboutMe()},
  <String, dynamic>{"state": false, "item": "Version 1.0.0", "onTap": () {}, "icon": FontAwesomeIcons.cubes, "screen": null},
];

Box<List<dynamic>>? world;
List<dynamic>? games = <Map<String, dynamic>>[];
Game? currentGame;

final List<List<GlobalKey<State>>> cellsStates = List<List<GlobalKey<State>>>.generate(6, (int _) => List<GlobalKey<State>>.generate(cellsSize, (int __) => GlobalKey<State>()));
final List<GlobalKey<State>> rowsStates = List<GlobalKey<State>>.generate(6, (int _) => GlobalKey<State>());
final GlobalKey<State> keyboardKey = GlobalKey<State>();
final GlobalKey<State> saveStateKey = GlobalKey<State>();
final GlobalKey<State> gameKey = GlobalKey<State>();
final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

bool save = false;

final List<String> allKeys = <String>[
  for (final List<Map<String, dynamic>> item in Game().keyboardMatrix_)
    for (final Map<String, dynamic> entry in item) entry["key"]
];

List<Map<String, String>> endGameAnalytics = <Map<String, String>>[
  <String, String>{"value": "0", "text": "Played"},
  <String, String>{"value": "0", "text": "Win %"},
  <String, String>{"value": "0", "text": "Current\nStreak"},
  <String, String>{"value": "0", "text": "Max\nStreak"},
];

const String description = "I'm Hafedh GUNICHI, a passionate Flutter developer with 2 years of experience. At 22 years old, I reside in Tunisia. I'm currently pursuing my studies in cybersecurity during my engineering program, building on my earlier foundation in computer science, which I completed during my bachelor's degree. In addition to my Flutter expertise, I'm skilled in Python, Mojo, and Firebase development. Throughout my academic journey, I've successfully completed various projects, honing my skills and gaining valuable experience.";

//add animation effects to the cells