import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/pages/AllStudents/DatabaseManager.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/StudentCourseRegistration.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/viewmodel/ProfilePageModel.dart';
import 'package:ourESchool/imports.dart';
import 'package:ourESchool/locator.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


class CourseRegistrationPage2 extends StatefulWidget
{
  const CourseRegistrationPage2({Key key, this.user}) : super(key: key);
  final AppUser user;
  @override
  _CourseRegistrationPage2 createState() => _CourseRegistrationPage2();
}

class _CourseRegistrationPage2 extends State<CourseRegistrationPage2>  with SingleTickerProviderStateMixin {

  String id='';
  SharedPreferencesHelper _sharedPreferencesHelper =
  locator<SharedPreferencesHelper>();

  final AuthenticationServices _auth = AuthenticationServices();
  UserType usertype =  locator<AuthenticationServices>().userType;
  List CourseList = [];
  List addOnList = [];


  @override
  void initState() {
    super.initState();
    getId();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getCourseList2(id);
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        CourseList = resultant;
      });
    }
  }

  fetchAddOnList() async {
    dynamic resultant = await DatabaseManager().getAddOnList2(id);
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        addOnList = resultant;
      });
    }
  }

  removeid (String id) async {
    await DatabaseManager().courseregsitrationedit(id);
  }

  removeid2 (String id) async {
    await DatabaseManager().courseregsitrationedit2(id);
  }
  removelist (String id) async {
    await DatabaseManager().cregisterupdate(id);
  }
  Future<void> getId() async {
    String s= await _sharedPreferencesHelper.getLoggedInUserId();
    id=s;
    fetchAddOnList();
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(
          title: 'Course Registration',
          child: kBackBtn,
          onPressed: () {
            kbackBtn(context);
          },
        ),
        body:
        Column(
          children: [
            Text("Courses", style: TextStyle(color: Colors.blueAccent,fontSize: 21.0,fontWeight: FontWeight.bold),),
            SingleChildScrollView(
              child: Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: CourseList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white60,
                          child: Card(
                            child: ListTile(
                              title: Text(''+CourseList[index]['name']),
                              subtitle: Text('id: '+CourseList[index]['id']+'\nInstructor: '+ CourseList[index]['instructor']+ '\nCredit: '+CourseList[index]['credit']),
                              leading: CircleAvatar(
                                child: Image(
                                  image: AssetImage('assets/f.png'),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text("Elective", style: TextStyle(color: Colors.blueAccent,fontSize: 21.0,fontWeight: FontWeight.bold),),
            SingleChildScrollView(
              child: Expanded(
                child: SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white60,
                          child: Card(
                            child: ListTile(
                              title: Text('NA'),
                              subtitle: Text(''),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text("Add On", style: TextStyle(color: Colors.blueAccent,fontSize: 21.0,fontWeight: FontWeight.bold),),
            SingleChildScrollView(
              child: Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: addOnList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white60,
                          child: Card(
                            child: ListTile(
                              title: Text(''+addOnList[index]['name']),
                              subtitle: Text('id: '+addOnList[index]['id']+'\nInstructor: '+addOnList[index]['instructor']),
                              leading: CircleAvatar(
                                child: Image(
                                  image: AssetImage('assets/f.png'),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            SizedBox(height: 20,),
            FlatButton(
                textColor: Colors.black,
                color: Colors.lightBlue,
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Text('EDIT',style: TextStyle(backgroundColor: Colors.lightBlue, fontSize: 20,),),
                  ],
                ),
                onPressed: (){
                showAlertDialog(context);
                }
            ),
          ],
        ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => CourseRegistrationPage2(),
        ),
      );},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {
        removeid(id);
        removelist(id);
        removeid2(id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => StudentStart(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit the registration"),
      content: Text("Would you like to continue ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
