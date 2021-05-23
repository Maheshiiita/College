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

class AdminStart extends StatefulWidget {
  const AdminStart({Key key, this.user}) : super(key: key);
  final AppUser user;

  @override
  _AdminStart createState() => _AdminStart();
}

class _AdminStart extends State<AdminStart> {

  final AuthenticationServices _auth = AuthenticationServices();
  UserType usertype =  locator<AuthenticationServices>().userType;
  List userProfilesList = [];
  String userID = "";

  @override
  void initState() {
    super.initState();

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

        ),
      ),
    );
  }

}
