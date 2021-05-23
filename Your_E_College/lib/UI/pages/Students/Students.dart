import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ColumnReusableCardButton.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/pages/shared/PDFOpener.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/imports.dart';
import 'package:random_color/random_color.dart';

class Student extends StatefulWidget {
  static String pageLabel = string.results;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<Student> {
  bool isTeacher = true;
  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: TopBar(
            title: 'Students',
            child: kBackBtn,
            onPressed: () {
              kbackBtn(context);
            }),
        floatingActionButton: Visibility(
          visible: isTeacher,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, i) => ColumnReusableCardButton(
              tileColor: _randomColor.randomColor(colorHue: ColorHue.blue),
              label: 'iit201910$i',
              icon: Icons.receipt,
              onPressed: () {
                kopenPage(
                  context,
                  ResultPage()
                );
              },
              height: 70,
            ),
          ),
        ),
      ),
    );
  }
}
