import './screens/login/login.dart';
import 'package:flutter/material.dart';
import './screens/overview/overview.dart';
import './screens/chat/chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(title: 'Login'),
      initialRoute: '/',
      routes: {
        '/ChatScreen': (context) => ChatScreen(
              isValid: false,
            ),
        '/OverviewScreen': (context) => OverviewScreen(),
        '/CenterConfirmButton': (context) => CenterConfirmButton(),
      },
    );
  }
}
