import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqlite_app/presentation/home.dart';

class SqliteApp extends StatelessWidget {
  const SqliteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SqliteApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Sqlite Application'),
    );
  }
}
