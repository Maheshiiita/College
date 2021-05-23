import 'package:flutter/material.dart';
import 'package:ourESchool/UI/pages/Dashboard/CommitteeFormation/screens/note_list.dart';
import 'package:ourESchool/UI/pages/Dashboard/CommitteeFormation/screens/studentList.dart';

class StudentViewCommittee extends StatefulWidget {
  const StudentViewCommittee({Key key}) : super(key: key);

  @override
  _StudentViewCommittee createState() => _StudentViewCommittee();
}

class _StudentViewCommittee extends State<StudentViewCommittee> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          headline: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24),
          body1: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20),
          body2: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 18),
          subtitle: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 14),
        ),
      ),
      home: NoteList1(),
    );

  }
}

