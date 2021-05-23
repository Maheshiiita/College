import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ReusableRoundedButton.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/UI/pages/Home.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/viewmodel/ProfilePageModel.dart';
import 'package:ourESchool/imports.dart';
import 'package:ourESchool/locator.dart';
import 'package:provider/provider.dart';
import 'package:ourESchool/core/helpers/SQL.dart';

import 'GuardianProfile.dart';

class ProfilePage extends StatefulWidget {

  static const id = 'ProfilePage';
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime dateOfBirth;
  UserType userType = UserType.UNKNOWN;
  bool guardiansPanel = false;
  String path = 'default';
  // String tempPath = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();






  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        dateOfBirth = picked;
        _dob = picked.toLocal().toString().substring(0, 10);
      });
    }
  }

  SharedPreferencesHelper _sharedPreferencesHelper =
      locator<SharedPreferencesHelper>();

  String _name = '';
  String _enrollNo = '';
  String _standard = '';
  String _division = '';
  String _dob = '';
  String _mobileNo = '';
  int a = 0;

  floatingButtonPressed(var model, UserType userType, User firebaseUser) async {
    bool res = false;

    // var firebaseUser = Provider.of<FirebaseUser>(context, listen: false);

    if (
        _division.isEmpty ||
        _name.isEmpty ||
        _dob.isEmpty ||
        _mobileNo.isEmpty ||
        _standard.isEmpty ||
        _enrollNo.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(ksnackBar(
          context, 'You Need to fill all the details and a profile Photo'));
    } else {

      if (model.state == ViewState.Idle) {
        res = await model.setUserProfileData(
          user: AppUser(
            displayName: _name.trim(),
            division: _division.trim(),
            dob: _dob.trim(),
            mobileNo: _mobileNo.trim(),
            standard: _standard.trim(),
            enrollNo: _enrollNo.trim(),
            email: firebaseUser.email,
            firebaseUuid: firebaseUser.uid,
            id: await _sharedPreferencesHelper.getLoggedInUserId(),
            isTeacher: userType == UserType.TEACHER ? true : false,
            isVerified: firebaseUser.emailVerified,
            photoUrl: path,
            connection: await getConnection(userType),
          ),
          userType: userType,
        );
      }
    }

    if (true) {
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (r) => false);
    }
  }

  Future<Map<String, dynamic>> getConnection(UserType userType) async {
    String connection = userType == UserType.STUDENT
        ? await _sharedPreferencesHelper.getParentsIds()
        : await _sharedPreferencesHelper.getChildIds();

    if (connection == 'N.A') {
      return null;
    }

    return jsonDecode(connection);
  }

  @override
  Widget build(BuildContext context) {

    userType = Provider.of<UserType>(context, listen: true); ///Changed to false
    var firebaseUser = Provider.of<User>(context, listen: true);

    if (userType == UserType.STUDENT) {
      guardiansPanel = false;
    } else {
      guardiansPanel = true;
    }


    return BaseView<ProfilePageModel>(

        onModelReady: (model) => model.getUserProfileData(),
        builder: (context, model, child) {

          return Scaffold(
            key: _scaffoldKey,
            appBar: TopBar(
              title: "Lets Start",
              child: kBackBtn,
              onPressed: () {
                if (model.state ==
                    ViewState.Idle) if (Navigator.canPop(context))
                  Navigator.pop(context);
              },
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Save',
              elevation: 20,
              backgroundColor: Colors.red,
              onPressed: () async {
                Navigator.pushNamedAndRemoveUntil(context, Home.id, (r) => false);
                // await floatingButtonPressed(model, userType, firebaseUser);
              },
              child: Icon(Icons.arrow_forward),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Image(image: AssetImage('assets/IIIT.png'),
                            height: 150),
                        Text(
                          'Welcome To ',
                          style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold, fontFamily: kFontFamily, color: Colors.deepPurple),
                        ),
                        Text(
                          ' IIIT Allahabad ',
                          style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w800, fontFamily: kFontFamily),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Image(image: AssetImage('assets/1.png'),
                                height: 150,
                                width:180),
                            SizedBox(width: 10,),
                            Image(image: AssetImage('assets/2.png'),
                                height: 150,
                                width:180),
                          ],
                        ),

                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Image(image: AssetImage('assets/3.png'),
                                height: 150,
                            width:180),
                            SizedBox(width: 10,),
                            Image(image: AssetImage('assets/4.png'),
                                height: 150,
                                width:180),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });


  }



  Widget buildProfilePhotoWidget(BuildContext context, ProfilePageModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
          child: Stack(
            children: <Widget>[
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Hero(
                  tag: 'profileeee',
                  transitionOnUserGestures: true,
                  child: Image(
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      image: setImage()),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 45,
                  width: 45,
                  child: Card(
                    elevation: 5,
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.black38,
                        size: 25,
                      ),
                      onPressed: () async {
                        String _path = await openFileExplorer(
                            FileType.image, mounted, context);
                        setState(() {
                          path = _path;
                          // tempPath = _path;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ImageProvider<dynamic> setImage() {
    if (path.contains('https')) {
      return NetworkImage(path);
    } else if (path == 'default' || path == null) {
      return AssetImage(assetsString.student_welcome);
    } else {
      return AssetImage(path);
    }
  }
}

class ProfileFields extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function onChanged;
  final double width;
  final Function onTap;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool isEditable;

  const ProfileFields(
      {@required this.labelText,
      this.hintText,
      this.onChanged,
      this.controller,
      this.onTap,
      this.textInputType,
      this.isEditable = true,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      // width: width == null ? MediaQuery.of(context).size.width / 2.5 : width,
      child: TextField(
        enabled: isEditable,
        onTap: onTap,
        controller: controller,
        // controller: TextEditingController(text: initialText),
        onChanged: onChanged,
        keyboardType: textInputType ?? TextInputType.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: kTextFieldDecoration.copyWith(
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
