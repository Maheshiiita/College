import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/pages/AllStudents/DatabaseManager.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/CourseRegsitrationPage2.dart';
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


class CRPage extends StatefulWidget
{
  const CRPage({Key key, this.user}) : super(key: key);
  final AppUser user;
  @override
  _CRPage createState() => _CRPage();
}

enum Start1 { True, False }

class _CRPage extends State<CRPage> {

  bool x = false;
  bool abc= false ;
  SharedPreferencesHelper _sharedPreferencesHelper =
  locator<SharedPreferencesHelper>();
  Start1 selected1 = Start1.False;
  final AuthenticationServices _auth = AuthenticationServices();
  UserType usertype =  locator<AuthenticationServices>().userType;
  var l=[];

  @override
  void initState() {
     upadting();
    super.initState();

  }


  Future<void> upadting () async {
   abc = await DatabaseManager().getR();
   print("Here bool is $abc");
   x=abc;
   if(abc)
   setState(() => selected1 = Start1.True);
   else
     setState(() => selected1 = Start1.False);
  }

  Future<void> getId() async {
    String s= await _sharedPreferencesHelper.getLoggedInUserId();
  }

  @override
  Widget build(BuildContext context) {

    print(abc);
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
          (selected1 == Start1.True) ?
          Container(
            child: Column(
              children : [
                FlatButton(
                    textColor: Colors.black,
                    color: Colors.lightBlue,
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text('Begin Registration',style: TextStyle(backgroundColor: Colors.lightBlue, fontSize: 20,),),
                        ],
                      ),
                    ),
                    onPressed: (){
                      kopenPage(context, StudentStart());
                    }
                ),
                FlatButton(
                    textColor: Colors.black,
                    color: Colors.lightBlue,
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text('Opt For Blank Semester',style: TextStyle(backgroundColor: Colors.lightBlue, fontSize: 20,),),
                      ],
                    ),
                    onPressed: (){
                      kopenPage(context, CourseRegistrationPage2());
                    }
                ),
               ]
            ),
          ) :
          Container(child: Center(child: Text("Course Registration Not Begun Yet", style: TextStyle(color: Colors.blueAccent,fontSize: 21.0,fontWeight: FontWeight.bold),))),
        ],
      ),
    );
  }
}
