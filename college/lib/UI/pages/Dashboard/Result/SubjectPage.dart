import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/pages/Dashboard/Result/ResultPage.dart';
import 'package:ourESchool/UI/pages/Dashboard/Result/ResultPageModel.dart';
import 'package:ourESchool/UI/pages/Students/TotalStudentsManager.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';

import '../../../../imports.dart';

class SubjectPage extends StatefulWidget {
  final String id;
  const SubjectPage({Key key,this.id}) : super(key: key);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<SubjectPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  List userProfilesList=[];
  List addon =[];

  @override
  void initState() {
    super.initState();
    fetchSubjectList(widget.id);
  }


  fetchSubjectList(String id) async {
    dynamic resultant = await ResultPageModel().getSubjectList(id);
    dynamic addon =await ResultPageModel().getAddon(id);
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        print('aa gayaaaaaaaaaa');
        print(id);
        userProfilesList = resultant;
        print(resultant);
        print("nahi ayaaaa");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String id='';
    return Scaffold(
        appBar: TopBar(
          title: 'Subjects',
          child: kBackBtn,
          onPressed: () {
            kbackBtn(context);
          },
        ),
        body: Column(

          children: [
            Flexible(
              child: Text('Core'),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: userProfilesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child:Container(
                        color: Colors.white60,
                        child: Card(
                          child: ListTile(
                            title: Text('Name: '+userProfilesList[index]['name']),
                            subtitle: Text('Subject Code: '+userProfilesList[index]['id']),

                          ),

                        ),

                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ResultPage(
                                id: widget.id,
                                subjectId: userProfilesList[index]['id'],
                              )
                          ),
                        );
                      },
                    );

                  }),
            ),
            Flexible(
              child: Text('AddOn'),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: addon.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child:Container(
                        color: Colors.white60,
                        child: Card(
                          child: ListTile(
                            title: Text('Name: '+addon[index]['name']),
                            subtitle: Text('Subject Code: '+addon[index]['id']),

                          ),

                        ),

                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ResultPage(
                                id: widget.id,
                                subjectId: addon[index]['id'],
                              )
                          ),
                        );
                      },
                    );

                  }),
            ),
          ],
        )
    );
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
