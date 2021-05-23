import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/imports.dart';

final  db = FirebaseDatabase.instance.reference().child("Transportation");

class TransportationPage extends StatelessWidget {
  const TransportationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int a=0,b=0,c=1;

    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        c= values["SB1"];
        print(values["Bus1"]);
      });
    });


    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: string.transportation,
      ),
      body: Container(
        child: Column(
          children: [
            Image(image: AssetImage('assets/Bus.jpg'),
              height: 250,
              width: 300,
          ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 100,
                  child: Text(
                    'Leaving Time',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepPurple),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 110,
                  child: Text(
                    'Returning Time ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepPurple),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 60,
                  child: Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepPurple),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 50,
                  child: Text(
                    'Count',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 100,
                  child: Text(
                    ' 4:30 pm ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 110,
                  child: Text(
                    ' 8:30 pm ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
               SizedBox(
                 width: 10,
               ),
                Container(
                  width: 45,
                  child: Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 20,
                  child: FlatButton(onPressed:(){
                    a++;
                  }, child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 10,
                  child: Text(
                    '$a',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 100,
                  child: Text(
                    ' 6:30 pm ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 110,
                  child: Text(
                    ' 9:30 pm ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 45,
                  child: Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 20,
                  child: FlatButton(onPressed:(){
                    b++;
                  }, child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 10,
                  child: Text(
                    '$b',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 100,
                  child: Text(
                    ' 10:00 am ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 110,
                  child: Text(
                    ' 11:30 am ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 45,
                  child: Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 20,
                  child: FlatButton(onPressed:(){
                    c++;
                  }, child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 10,
                  child: Text(
                    '$c',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}