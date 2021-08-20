import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_7/addbook.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyHome());

class MyApp extends StatelessWidget {
  final String title;
  MyApp({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      drawer: Drawer(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
             UserAccountsDrawerHeader(
               accountName: Text('accountName'), 
               accountEmail: Text('accountEmail'),
               currentAccountPicture: CircleAvatar(
                 child: FlutterLogo(size:40.0,),
                backgroundColor: Colors.white,
                 ), 
                otherAccountsPictures: <Widget>[
                  CircleAvatar(
                    child: Text('P'),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.amber,
                  ),
                  CircleAvatar(
                    child: Icon(Icons.add),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey,
                  )
                ],
               ),
              ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    Navigator.pushNamed(context, '/addbook');
                  }),
              ListTile(
                title: Text('Item 2'),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
      body: Center(
          child: ListView(children: <Widget>[
        MyRadio(),
      ])),
    );
  }
}

class MyHome extends StatelessWidget {
  final appTitle = 'Example Form';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      routes: {
        //      '/homepage': (context) => Homepage(),
        '/addbook': (context) => AddBookPage(),
      },
      home: MyApp(title: appTitle),
    );
  }
}

class MyRadio extends StatefulWidget {
  MyRadio({Key key}) : super(key: key);

  @override
  _MyRadioState createState() => _MyRadioState();
}

class _MyRadioState extends State<MyRadio> {
  dynamic sex;
  bool checkboxValueA = true;
  bool checkboxValueB = true;
  List<String> provices = ['', 'BKK', 'Outbound'];
  dynamic provice = '';
  final _format = DateFormat('dd/MM/yyyy');
   File _avatar;
   
@override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            radioRow(),
            Row(children: [
              Text('$sex'),
            ]),
            checkBoxRow(),
            Row(children: [
              Text('$checkboxValueA'),
              Text('$checkboxValueB'),
            ]),
            buildSelectField(),
            buildDateField(),
            _avatar == null ? ElevatedButton(
              onPressed: (){
                onChooseImage();
              },
              child: Text('Choose Avatar'),
              )
              : Image.file(_avatar),
              Row(
                children: <Widget>[
                ElevatedButton(
                onPressed: (){
                  onChooseImage();
                },
                child: Text('Change Image'),
                )
                ],
              )
          ]),
    );
  }

Row checkBoxRow() {
  return Row(children: [
            Checkbox(
              value: checkboxValueA,
              onChanged: (bool value) {
                setState(() {
                  checkboxValueA = value;
                });
              },
            ),
            Text('CheckBox A'),
            Checkbox(
              value: checkboxValueB,
              onChanged: (bool value) {
                setState(() {
                  checkboxValueB = value;
                });
              },
            ),
            Text('CheckBox B'),
          ]);
}

DateTimeField buildDateField() {
    return DateTimeField(
      decoration: InputDecoration(labelText: 'Birth Date'),
      format: _format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }

Row radioRow() {
    return Row(children: [
      Radio(
        value: 'M',
        groupValue: sex,
        onChanged: (value) {
          setState(() {
            sex = value;
          });
        },
      ),
      Text('Male'),
      Radio(
        value: 'F',
        groupValue: sex,
        onChanged: (value) {
          // _handleTapboxChanged(value);
          setState(() {
            sex = value;
          });
        },
      ),
      Text('Female'),
    ]);
  }

InputDecorator buildSelectField() {

    return InputDecorator(
      decoration: InputDecoration(labelText: 'Province'),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: provice,
          onChanged: (value) {
            setState(() {
              provice = value;
            });
          },
          items: provices
              .map(
                (value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

onChooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
    source: ImageSource.camera);
    
    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

}
