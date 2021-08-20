import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  AddBookPage({Key key}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AddBook Page'
        ),
      ),
      body: Text('Addbook Body'),
    );
  }
}
