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

class ViewResultPage extends StatefulWidget {
  const ViewResultPage({Key key}) : super(key: key);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<ViewResultPage> {
  String _id='';
  List userProfilesList=[];

  @override
  void initState() {
    super.initState();
    fetchSubjectList();
  }

  fetchSubjectList() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
    locator<SharedPreferencesHelper>();
    _id = await _sharedPreferencesHelper.getLoggedInUserId();
    dynamic resultant = await ResultPageModel().getSubjectList(_id);
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        print('aa gayaaaaaaaaaa');
        print(_id);
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
        body: Container(
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
                              id: _id,
                              subjectId: userProfilesList[index]['id'],
                            )
                        ),
                      );
                    },
                  );

                })));
  }
}
