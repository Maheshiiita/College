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
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/viewmodel/ProfilePageModel.dart';
import 'package:ourESchool/imports.dart';
import 'package:ourESchool/locator.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


class DirectorStart extends StatefulWidget
{
  const DirectorStart({Key key, this.user}) : super(key: key);
  final AppUser user;
  @override
  _DirectorStart createState() => _DirectorStart();
}

class _DirectorStart extends State<DirectorStart>  with SingleTickerProviderStateMixin {

  String a,b,c,id;
  int count;
  SharedPreferencesHelper _sharedPreferencesHelper =
  locator<SharedPreferencesHelper>();
  List CList = [];

  final AuthenticationServices _auth = AuthenticationServices();
  UserType usertype =  locator<AuthenticationServices>().userType;


  @override
  void initState() {
    super.initState();
    getId();
    fetchDatabaseList();
  }


  Future<String> getId() async {
    String s= await _sharedPreferencesHelper.getLoggedInUserId();
    id=s;
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getRegisterList();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        CList = resultant;
        count=CList.length;
      });
    }
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
      body:Column(
        children: [
          Text("Total Regsitered Students", style: TextStyle(color: Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold),),
          Text('$count', style: TextStyle(color: Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold),),
          SingleChildScrollView(
            child: Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: CList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white60,
                        child: Card(
                          child: ListTile(
                            title: Text(''+CList[index]['id']),
                            leading: CircleAvatar(
                              child: Image(
                                image: AssetImage('assets/gra.png'),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ]
      )

    );
  }

}
