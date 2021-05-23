import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ColumnReusableCardButton.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/pages/Students/Sem0.dart';
import 'package:ourESchool/UI/pages/shared/PDFOpener.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:random_color/random_color.dart';
import 'package:ourESchool/UI/pages/Dashboard/Result/ResultPageModel.dart';

import '../../../../imports.dart';
import '../../../../locator.dart';


class ResultPage extends StatefulWidget {
  final String id;
  final String subjectId;
  const ResultPage({Key key,this.id,this.subjectId}) : super(key: key);
  static String pageLabel = string.results;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
{
  SharedPreferencesHelper _sharedPreferencesHelper =
  locator<SharedPreferencesHelper>();
  List userMarksList = [];
  String _c1 = '';
  String _c2 = '';
  String _c3 = '';
  String _c1c2status = '';
  String _c3status='';
  String _attendancestatus='';

  @override
  void initState() {
    super.initState();
    print('itsss time to get marks');
    fetchMarksList(widget.id,widget.subjectId);
    print("////////////////////");
    print(widget.id);
  }


  fetchMarksList(String id,String subjectId) async{
     dynamic resultant= await ResultPageModel().getMarks(id,subjectId);
     print('gotttt ittttt');
     print(id);
    print(resultant);
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        _c1=resultant[0]['c1'];
        _c2=resultant[0]['c2'];
        _c3=resultant[0]['c3'];
        _c1c2status=resultant[0]['c1+c2'];
        _c3status=resultant[0]['c3+status'];
        _attendancestatus=resultant[0]['attendance'];
      });
    }
  }

  floatingButoonPressed(String id,String subjectId) async{
    ResultPageModel rs =new ResultPageModel();
    if(_c1!=null&&_c2!=null){
      int a = int.parse(_c1);
      int b=int.parse(_c2);
      if(a+b<18)
      _c1c2status='Summer Semester';
      else _c1c2status='U R Welcome 4 C3';
    }
    if(_c3!=null){
      int a = int.parse(_c3);
      if(a<12)
      _c3status='Get Ready 4 Backpaper';
    }
    await rs.createResultData(id, _c1, _c2, _c3,_c1c2status,_c3status,_attendancestatus,subjectId);
    print('doneeeeeeeeee');
  }

  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<UserType>(context, listen: false);
    bool isteacher=false;
    if(userType == UserType.TEACHER)isteacher=true;
    return Scaffold(
      appBar: TopBar(
        title: 'Marks',
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
      ),

      floatingActionButton: Visibility(
        visible: isteacher,
        child:FloatingActionButton(
          tooltip: 'Save',
          elevation: 20,
          backgroundColor: Colors.red,
          onPressed: () async {
            await floatingButoonPressed(widget.id,widget.subjectId);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20),
              child: Column(
                children: <Widget>[
                  ResultUpload(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    hintText: "C1",
                    initialText: 'N/A',
                    onChanged: (name) {
                      print(name);
                      _c1 = name;
                    },
                    controller: TextEditingController(text: _c1),
                  ),
                  ResultUpload(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    hintText: "C2",
                    initialText: 'N/A',
                    onChanged: (name) {
                      print(name);
                      _c2 = name;
                    },
                    controller: TextEditingController(text: _c2),
                  ),
                  ResultUpload(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    hintText: "C3",
                    initialText: 'N/A',
                    onChanged: (name) {
                      print(name);
                      _c3 = name;
                    },
                    controller: TextEditingController(text: _c3),
                  ),
                  ResultUpload(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    hintText: "C1+c2 status",
                    initialText: 'Not declared yet',
                    onChanged: (name) {
                      print(name);
                      _c1c2status = name;
                    },
                    controller: TextEditingController(text: _c1c2status),
                  ),
                  ResultUpload(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    hintText: "C3 Status",
                    initialText: 'Not declared yet',
                    onChanged: (name) {
                      print(name);
                      _c3status = name;
                    },
                    controller: TextEditingController(text: _c3status),
                  ),
                  ResultUpload(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    hintText: "Attendance Status",
                    initialText: 'Not declared yet',
                    onChanged: (name) {
                      print(name);
                      _attendancestatus = name;
                    },
                    controller: TextEditingController(text: _attendancestatus),
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

class ResultUpload extends StatelessWidget {
  final String initialText;
  final String hintText;
  final double width;
  final Function onChanged;
  final Function onTap;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool isEditable;


  const ResultUpload(
      {this.initialText, @required this.hintText, this.width, this.onChanged,
        this.onTap ,
        this.textInputType,
        this.isEditable = true,
        this.controller});

  @override
  Widget build(BuildContext context) {
    print('*****************');
    var userType = Provider.of<UserType>(context, listen: false);
    if(userType==UserType.TEACHER)print('yessssssssssssss');
    else print('noooooooooooooooooo');
    if(userType==UserType.TEACHER) return Container(
      height: 70,
      // width: width == null ? MediaQuery.of(context).size.width / 2.5 : width,
      child: TextField(
        enabled: true,
        keyboardType: TextInputType.text,
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintStyle: TextStyle(height: 2.0, fontWeight: FontWeight.w300),
          contentPadding:
          EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
      ),
    );
    else{
      return Container(
        height: 70,
        // width: width == null ? MediaQuery.of(context).size.width / 2.5 : width,
        child: TextField(
          enabled: false,
          keyboardType: TextInputType.text,
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            labelText: hintText,
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
}
