import 'package:flutter/material.dart';
import 'package:pdam/pages/home.dart';

main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "PDAM",
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
    home: const HomePage(),
  ));
}