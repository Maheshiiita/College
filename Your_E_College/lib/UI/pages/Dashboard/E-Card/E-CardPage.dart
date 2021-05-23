import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/pages/AllStudents/DatabaseManager.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/viewmodel/ProfilePageModel.dart';
import 'package:ourESchool/locator.dart';
import 'package:provider/provider.dart';

class ECardPage extends StatefulWidget {
  const ECardPage({Key key, this.user}) : super(key: key);
  final AppUser user;

  @override
  _ECardPageState createState() => _ECardPageState();
}

class _ECardPageState extends State<ECardPage> {

  final AuthenticationServices _auth = AuthenticationServices();
  UserType usertype =  locator<AuthenticationServices>().userType;
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
   dynamic resultant = await DatabaseManager().getUsersList2(
        locator<AuthenticationServices>().userType.toString());
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  updateData(String usertype, String name, String rollNo, String semester,
      String course, String branch, String batch, String uid) async {
    await DatabaseManager().updateUserList(
        usertype,
        name,
        rollNo,
        semester,
        course,
        branch,
        batch,
        uid);
    fetchDatabaseList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: string.e_card,
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Hero(
                  tag: 'profileeee',
                  transitionOnUserGestures: true,
                  child: Container(
                    constraints:
                    BoxConstraints(maxHeight: 200, maxWidth: 200),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,r
                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image:
                        AssetImage(
                            assetsString.student_welcome),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20),
              child: Column(
                children: <Widget>[
                  ProfileFieldsECard(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    labelText: "name",
                    initialText: userProfilesList[0]['displayName'],
                  ),
                  usertype == UserType.PARENT
                      ? Container()
                      : ProfileFieldsECard(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    labelText: string.student_or_teacher_id,
                    initialText:  userProfilesList[0]['rollNo'],
                  ),
                  usertype == UserType.PARENT || usertype == UserType.TEACHER
                      ? Container()
                      : Column(
                        children: [
                          Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                          Expanded(
                            child: ProfileFieldsECard(
                              labelText: 'Branch',
                              initialText:userProfilesList[0]['branch'],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ProfileFieldsECard(
                              labelText:'Batch',
                              initialText:
                              userProfilesList[0]['batch'],
                            ),
                          ),
                    ],
                  ),
                          ProfileFieldsECard(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            labelText:"Courses",
                            initialText: userProfilesList[0]['courses'],
                          ),
                          Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: ProfileFieldsECard(
                                  labelText: 'Semester',
                                  initialText: userProfilesList[0]['semester'],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class ProfileFieldsECard extends StatelessWidget {
  final String initialText;
  final String labelText;
  final double width;

  const ProfileFieldsECard(
      {this.initialText, @required this.labelText, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      // width: width == null ? MediaQuery.of(context).size.width / 2.5 : width,
      child: TextField(
        enabled: false,
        controller: TextEditingController(text: initialText),
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintStyle: TextStyle(height: 2.0, fontWeight: FontWeight.w300),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
      ),
    );
  }
}
