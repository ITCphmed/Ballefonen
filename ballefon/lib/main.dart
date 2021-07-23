library passcode_screen;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 54, 90, 1),
        primarySwatch: Colors.blue,
        buttonColor: Colors.white,
      ),
      home: ExampleHomePage(title: 'Login Screen'),
      initialRoute: '/',
      routes: {
        '/ChatScreen': (context) => ChatScreen(),
        '/OverviewScreen': (context) => OverviewScreen(),
        '/CenterConfirmButton': (context) => CenterConfirmButton(),
      },
    );
  }
}

const storedPasscode = '123456';

class ExampleHomePage extends StatefulWidget {
  ExampleHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[_defaultLockScreenButton(context)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Vælg venligst dit center"),
            Container(
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Color.fromRGBO(0, 54, 90, 0.95),
              ),
              child: Align(
                alignment: Alignment.center,
                child: _centreChooser(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _defaultLockScreenButton(BuildContext context) => IconButton(
        icon: Icon(Icons.person_add),
        color: Theme.of(context).buttonColor,
        onPressed: () {
          _showLockScreen(
            context,
            opaque: false,
            cancelButton: Text(
              'Cancel',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Cancel',
            ),
          );
        },
      );

  String centres = "CPHMED Bella Center";
// GAYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
  _centreChooser(BuildContext context) => DropdownButton<String>(
        value: centres,
        icon: const Icon(Icons.arrow_downward, color: Colors.white),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        onChanged: (String? newValue) {
          setState(() {
            centres = newValue!;
          });
          Navigator.pushNamed(context, '/CenterConfirmButton');
        },
        items: <String>[
          'CPHMED Bella Center',
          'CPHMED Ballerup',
          'CPHMED Ørestad',
          'CPHMED Hellerup',
          'CPHMED Herlev',
          'CPHMED Lyngby',
          'CPHMED Parken',
          'CPHMED Forum',
          'CPHMED Skibby',
          'CPHMED Frederikssund',
          'CPHMED Frederiksværk',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    required Widget cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
            title: Text(
              'Enter App Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              'Delete',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Delete',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
            passwordDigits: 6,
            bottomWidget: _buildPasscodeRestoreButton(),
            isValidCallback: _loginButton,
          ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

/*   @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  } */

  _buildPasscodeRestoreButton() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: TextButton(
            child: Text(
              "Log ind",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            onPressed: _loginButton,
            // splashColor: Colors.white.withOpacity(0.4),
            // highlightColor: Colors.white.withOpacity(0.2),
            // ),
          ),
        ),
      );

  _loginButton() {
    if (isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
    }
/*       _showRestoreDialog(() {
        Navigator.maybePop(context); */
    //TOdO: Clear your stored passcode here);
  }
}

class CenterConfirmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Hol' up!"),
      content: Text("Is this your centre?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/ChatScreen');
          },
          child: Container(
            child: Text("Yes"),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Text("Nope"),
          ),
        )
      ],
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chat Screen"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/OverviewScreen');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Color.fromRGBO(0, 54, 90, 1),
        child: Icon(Icons.question_answer_sharp),
      ),
    );
  }
}

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Overview Screen"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/ChatScreen');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Color.fromRGBO(0, 54, 90, 1),
        child: Icon(Icons.question_answer_sharp),
      ),
    );
  }
}
