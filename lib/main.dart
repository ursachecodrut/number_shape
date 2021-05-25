import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:core';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Shape',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.cyan
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  String? _output;

  static bool isSquare(int num) {
    if (num >= 0) {
      int val = sqrt(num).toInt();
      return ((val * val) == num);
    }
    return false;
  }

  static bool isTriangular(int num) {
    int n = pow(num, 1.0 / 3.0).round();
    if (num == n * n * n) {
      return true;
    }
    return false;
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: Text("Try again"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text(
        _output!,
      ),
      actions: [
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _checkNumber(String string) {
    try {
      if (isSquare(int.parse(string)) && isTriangular(int.parse(string))) {
        _output = 'Number $string is both SQUARE and TRIANGULAR';
      } else if (isSquare(int.parse(string))) {
        _output = 'Number $string is SQUARE';
      } else if (isTriangular(int.parse(_controller.value.text))) {
        _output = 'Number $string is TRIANGULAR';
      } else {
        _output = 'Number $string is neither SQUARE or TRIANGULAR';
      }
    } catch (err) {
        _output = 'Invalid input. Please enter an interger value';
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number shape"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Please enter a number to see if it\'s square or triangular',
              style: Theme.of(context).textTheme.headline6,
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _controller,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _checkNumber(_controller.text);
          showAlertDialog(context);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
