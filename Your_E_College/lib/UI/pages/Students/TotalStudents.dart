import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/pages/Dashboard/Result/ResultPage.dart';
import 'package:ourESchool/UI/pages/Dashboard/Result/SubjectPage.dart';
import 'package:ourESchool/UI/pages/Students/TotalStudentsManager.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';

import '../../../locator.dart';

class StudentScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<StudentScreen> {
  final AuthenticationServices _auth = AuthenticationServices();

  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  List<dynamic> userProfilesList = [];

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
    dynamic resultant = await DatabaseManager().getStdList();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        print('aa gayaaaaaaaaaa');
        userProfilesList = resultant;
        print("nahi ayaaaa");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String id='';
    return Scaffold(
        appBar: TopBar(
        title: 'Students',
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
    ),
        body: Container(
            child: userProfilesList.length==0
            ? Container(
              child: Center(
                child: Text(
                  'No Students Registered....!',
                  textAlign: TextAlign.center,
                  style:
                  ksubtitleStyle.copyWith(fontSize: 25),
                ),
              ),
            )
            : ListView.builder(
                itemCount: userProfilesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      child:Container(
                        color: Colors.white60,
                        child: Card(
                          child: ListTile(
                            title: Text('Name: '+userProfilesList[index]['displayName']),
                            subtitle: Text('RollNo: '+userProfilesList[index]['rollNo']+'\nSemester: '+userProfilesList[index]['semester']+'\nBranch: '
                                +userProfilesList[index]['branch']),
                            leading: CircleAvatar(
                              child: Image(
                                image: AssetImage('assets/IIIT.png'),
                              ),
                            ),
                            trailing: Text('${userProfilesList[index]['batch']}'),

                          ),

                        ),

                      ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubjectPage(
                            id: userProfilesList[index]['rollNo'],
                          )
                        ),
                      );
                    },
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

          );
        });
  }
}
