import 'package:alarm_app/add_alarm.dart';
import 'package:alarm_app/alarm_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/add-alarm': (context) => AddAlarm(),
      },
      theme: ThemeData(
        primaryColor: const Color(0xff1b2c57),
        accentColor: const Color(0xff65d1ba),
      ),
      home: const Home(),
    );
  }
}
