import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/pages/AllStudents/DatabaseManager.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/UI/pages/Dashboard/CourseRegistration/CourseRegsitrationPage2.dart';
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


class StudentStart extends StatefulWidget
{
  static const id1 = 'CourseRegistration';
  const StudentStart({Key key, this.user}) : super(key: key);
  final AppUser user;
  @override
  _StudentStart createState() => _StudentStart();
}

class _StudentStart extends State<StudentStart>  with SingleTickerProviderStateMixin {

  var _isSelected=[];
  var _isSelected2=[];
  String id='';
  SharedPreferencesHelper _sharedPreferencesHelper =
  locator<SharedPreferencesHelper>();

  final AuthenticationServices _auth = AuthenticationServices();
  UserType usertype =  locator<AuthenticationServices>().userType;
  List CourseList = [];
  List CCourseList = [];
  List addOnList = [];
  List CaddOnList = [];


  @override
  void initState() {
    super.initState();
    getId();
    fetchAddOnList();
    fetchDatabaseList();
  }


  Future<void> getId() async {
  String s= await _sharedPreferencesHelper.getLoggedInUserId();
  id=s;
  idpresent(s);
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getCourseList('1');
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
       CourseList = resultant;
       CourseList.forEach((element) {_isSelected2.add(false);});
      });
    }
  }

  fetchAddOnList() async {
    dynamic resultant = await DatabaseManager().getAddOnList();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
       addOnList = resultant;
       addOnList.forEach((element) {_isSelected.add(false);});
      });
    }
  }

  addtoRegister(String id) async {
    await DatabaseManager().cregister(id);
  }

  createAddOnList(String a , String name, String id, String instructor) async {
    await DatabaseManager().createAddOnData(a, name, id, instructor);
  }

  idpresent(String id) async {
   int x= await DatabaseManager().isthere(id);
   if(x==1) {
     Navigator.push(
       context,
       MaterialPageRoute(
         builder: (BuildContext context) => CourseRegistrationPage2(),
       ),
     );
   }
  }

  createCourseList(String a , String name, String id, String instructor, String credit) async {
    await DatabaseManager().createCourseData(a, name, id, instructor, credit);
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
                              child: CheckboxListTile(
                                title: Text(''+CourseList[index]['name']),
                                subtitle: Text('id: '+CourseList[index]['id']+'\nInstructor: '+ CourseList[index]['instructor']+ '\nCredit: '+CourseList[index]['credit']),
                                value:  _isSelected2[index],
                                onChanged:  (bool newValue) {
                                  setState(() {
                                    _isSelected2[index] = newValue;
                                    if(_isSelected2[index]==true)
                                    {
                                      CCourseList.add(CourseList[index]);
                                      print(CourseList[index]['name']);
                                    }
                                    else
                                    {
                                      CCourseList.removeWhere((element) => element.name=CourseList[index]['name']);
                                    }
                                  });
                                },
                                secondary: const Image( image: AssetImage('assets/pen.png'),),

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
                                         child: CheckboxListTile(
                                        title: Text(''+addOnList[index]['name']),
                                        subtitle: Text('id: '+addOnList[index]['id']+'\nInstructor: '+addOnList[index]['instructor']),
                                           value:  _isSelected[index],
                                           onChanged:  (bool newValue) {
                                             setState(() {
                                               _isSelected[index] = newValue;
                                               if(_isSelected[index]==true)
                                               {
                                                 CaddOnList.add(addOnList[index]);
                                                 print(CaddOnList[index]['name']);
                                               }
                                               else
                                                 {
                                                   CaddOnList.removeWhere((element) => element.name=addOnList[index]['name']);
                                                 }
                                             });
                                           },
                                           secondary: const Image( image: AssetImage('assets/pen.png'),),

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
                child: Text('Submit',style: TextStyle(backgroundColor: Colors.lightBlue, fontSize: 20,),),
                onPressed: (){ CaddOnList.forEach((element) {
                  createAddOnList(id, element['name'], element['id'], element['instructor']);
                });
                CCourseList.forEach((element) {
                  createCourseList(id, element['name'], element['id'], element['instructor'], element['credit']);
                  },);
                addtoRegister(id);
                Toast.show('Submitted', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CourseRegistrationPage2(),
                  ),
                );
                }
              ),
            ],
          ),



    );
  }

}
