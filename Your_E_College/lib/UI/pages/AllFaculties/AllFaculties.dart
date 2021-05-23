import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/pages/AllStudents/DatabaseManager.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';

import '../../../locator.dart';

class DashboardScreenF extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreenF> {
  final AuthenticationServices _auth = AuthenticationServices();

  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  List userProfilesList = [];

  String userID = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchDatabaseList();
  }

  fetchUserInfo() async {
    User getUser = await _auth.getFirebaseUser();
    userID = getUser.uid;
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList('TEACHER');
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  updateData(String usertype, String name, String rollNo, String semester, String course, String branch, String batch, String uid) async {
    await DatabaseManager().updateUserList(usertype,name, rollNo,semester,course,branch,batch,uid);
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          actions: [
            RaisedButton(
              onPressed: () {
                openDialogueBox(context);
              },
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              color: Colors.deepPurple,
            ),
          ],
        ),
        body: Container(
            child: ListView.builder(
                itemCount: userProfilesList.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white60,
                    child: Card(
                      child: ListTile(
                        title: Text('Name: '+userProfilesList[index]['displayName']),
                        subtitle: Text('RollNo: '+userProfilesList[index]['rollNo']+'\nSemester: '+userProfilesList[index]['semester']+'\nCourse: '+userProfilesList[index]['course']+'\nBranch: '
                            +userProfilesList[index]['branch']),
                        leading: CircleAvatar(
                          child: Image(
                            image: AssetImage('assets/IIIT.png'),
                          ),
                        ),
                        trailing: Text('${userProfilesList[index]['batch']}'),
                      ),
                    ),
                  );
                })));
  }

  openDialogueBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit User Details'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                  TextField(
                    controller: rollNoController,
                    decoration: InputDecoration(hintText: 'rollNo'),
                  ),
                  TextField(
                    controller: semesterController,
                    decoration: InputDecoration(hintText: 'semester'),
                  ),
                  TextField(
                    controller: courseController,
                    decoration: InputDecoration(hintText: 'course'),
                  ),
                  TextField(
                    controller: branchController,
                    decoration: InputDecoration(hintText: 'branch'),
                  ),
                  TextField(
                    controller: batchController,
                    decoration: InputDecoration(hintText: 'batch'),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  submitAction(context);
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  submitAction(BuildContext context) {
    updateData(locator<AuthenticationServices>().userType.toString() ,nameController.text, rollNoController.text,semesterController.text,courseController.text,branchController.text,batchController.text, userID);
    nameController.clear();
    rollNoController.clear();
    semesterController.clear();
    courseController.clear();
    courseController.clear();
    branchController.clear();
    batchController.clear();
  }
}
