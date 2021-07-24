import 'package:flutter/material.dart';

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
