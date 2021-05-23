import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import '../../../../locator.dart';
import 'package:ourESchool/imports.dart';

class ResultPageModel {
  final CollectionReference profileList =
  FirebaseFirestore.instance.collection('Colleges');

  Future<void> createResultData(String uid,String c1,String c2,String c3,String c1c2staus,c3status,attendancestatus,String subid) async {
    print('yayyyyyyyyyyyyyyyyy');
    print(uid + " "+c1+" "+c2+" "+c3);
    await profileList.doc('India').collection('IIITA').doc('Result').collection('2019').doc(uid);
    await profileList.doc('India').collection('IIITA').doc('Result').collection('2019').doc(uid).collection('core').doc(subid).set({'c1':c1,'c2':c2,'c3':c3,'c1+c2':c1c2staus,'c3+status':c3status,'attendance':attendancestatus});
    return;
  }

  Future updateResultList(String uid,String c1,String c2,String c1c2staus,c3status,attendancestatus,String c3) async {
    return await profileList.doc('India').collection('IIITA').doc('Result').collection('2019').doc(uid).update({
      'c1':c1,'c2':c2,'c3':c3
    });
  }

  Future getMarks(String id,String subjectId) async {
    List markslist=[];
    try {
      await profileList.doc('India').collection('IIITA').doc('Result').collection('2019').doc(id).collection('core').doc(subjectId).get().then((value) {
        markslist.add(value.data());
        print(value.data());
      });
      return markslist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getSubjectList(String id) async {
    List itemsList = [];
    try {
      await profileList.doc('India').collection('IIITA').doc('CourseSelected').collection('Btech-IT').doc(id).collection('core').get().then((querySnapshot) {

        querySnapshot.docs.forEach((element) {
          print(element.data());
          itemsList.add(element.data());
        });
      });
      return itemsList;

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getAddon(String id) async {
    List itemsList = [];
    try {
      await profileList.doc('India').collection('IIITA').doc('CourseSelected').collection('Btech-IT').doc(id).collection('Addon').get().then((querySnapshot) {

        querySnapshot.docs.forEach((element) {
          print(element.data());
          itemsList.add(element.data());
        });
      });
      return itemsList;

    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}