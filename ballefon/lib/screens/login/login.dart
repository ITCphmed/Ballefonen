library passcode_screen;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => LoginState();
}

const storedPasscode = '123456';

class LoginState extends State<Login> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  // List<DropdownMenuItem<String>> list;
  // @override
  // void initState() {
  //   super.initState();
  //   list = [];
  //   DB.initialize().then((status) {
  //     if(status) {
  //       DB.getData().then((listMap) {
  //         listMap.map((map) {
  //           print(map.toString());
  //           return getDropdownWidget(map);
  //         })
  //       })
  //     }
  //   })
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          actions: <Widget>[_defaultLockScreenButton(context)],
        ),
        body: Center(
          child: DropdownButton(
              hint: Text("Vælg et center"), onChanged: (value) {}, items: null),
        ));
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
            bottomWidget: null,
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

  _loginButton() {
    if (isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login(title: "Login2")),
      );
    }
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
