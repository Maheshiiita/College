import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'Login/LoginPage.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = 'WelcomeScreen';
  static UserType loginType = UserType.STUDENT;

  List<PageViewModel> page(BuildContext context) {
    return [
      PageViewModel(
        iconColor: kmainColorTeacher,
        pageColor: Colors.deepPurple,
        // bubbleBackgroundColor: Colors.white,
        title: Container(),
        body: Column(
          children: <Widget>[
            Text(
             "Your E College",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
            Text(
            "IIIT Allahabad",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        mainImage: Image.asset(
          assetsString.student_welcome,
          width: MediaQuery.of(context).size.width - 60,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.white),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          IntroViewsFlutter(
            page(context),
            onTapDoneButton: null,
            showNextButton: true,
            showBackButton: true,
            showSkipButton: true,
            doneText: Container(),
            pageButtonsColor: Colors.black38,
            pageButtonTextStyles: new TextStyle(
              color: Colors.indigo,
              fontSize: 16.0,
            ),
          ),
          Positioned(
            bottom: 60.0,
            width: MediaQuery.of(context).size.width,
            // left: MediaQuery.of(context).size.width/2 - 40,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Hero(
                tag: 'title',
                transitionOnUserGestures: true,
                child: MaterialButton(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width ,
                  elevation: 10,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.only(
                  //     // bottomRight: Radius.elliptical(40, 1),
                  //     topRight: Radius.circular(1000),
                  //   ),
                  // ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  },
                  color: Colors.white,
                  child: Text(
                    string.get_started,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
