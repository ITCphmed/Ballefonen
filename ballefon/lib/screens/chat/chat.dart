import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final bool isValid;
  ChatScreen({required this.isValid});

  @override
  _ChatScreenState createState() => _ChatScreenState(isValid);
}

class _ChatScreenState extends State<ChatScreen> {
  bool isValid;
  _ChatScreenState(this.isValid);

  @override
  Widget build(BuildContext context) {
    if (isValid == true) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Overview Screen"),
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
      // Følgende kode skal erstattes med noget andet, ellers skal If statementen rykkes op
      // så den gemmer knappen, i stedet for at vise et helt scaffold
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("VALID = FALSE"),
        ),
      ); // Slut
    }
  }
}
