import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/imports.dart';

import '../../../locator.dart';

class DatabaseManager {

  final CollectionReference profileList =
  FirebaseFirestore.instance.collection('Colleges');

  Future<void> createUserData(String usertype,String name, String rollNo, String semester, String course, String branch, String batch, String uid) async {
    if(usertype == locator<AuthenticationServices>().userType.toString())
    {
      return await profileList.doc('India').collection('IIITA').doc('Profile')
          .collection('Student').doc(uid).set({
        'displayName': name,
        'rollNo': rollNo,
        'semester': semester,
        'course': course,
        'branch': branch,
        'batch': batch
      });
    }
    else
    {
      return await profileList.doc('India').collection('IIITA').doc('Profile')
          .collection('Admin-Faculty').doc(uid).set({
        'displayName': name,
        'rollNo': rollNo,
        'semester': semester,
        'course': course,
        'branch': branch,
        'batch': batch
      });
    }
  }


  Future<void> updateR(bool s) async {

      return await profileList.doc('India').collection('IIITA').doc('CR')
          .update({
          'status' : s
      });

  }


  Future<bool> getR() async {

   DocumentSnapshot sp= await profileList.doc('India').collection('IIITA').doc('CR').get() ;
   bool x= sp.data()['status'];
   return x;
  }




  Future updateUserList(String usertype, String name, String rollNo, String semester, String course, String branch, String batch, String uid) async {
    if(usertype== locator<AuthenticationServices>().userType.toString() )
      {
        return await profileList.doc('India').collection('IIITA').doc('Profile')
        .collection('Student').doc(uid).update({
      'displayName': name, 'rollNo': rollNo, 'semester': semester , 'course': course, 'branch': branch,'batch': batch
    });
      }
    else {
        return await profileList.doc('India').collection('IIITA').doc('Profile')
        .collection('Admin-Faculty').doc(uid).update({
      'displayName': name, 'rollNo': rollNo, 'semester': semester , 'course': course, 'branch': branch,'batch': batch
    });
    }
  }

  Future<List> getUsersList(String usertype) async {
    List itemsList = [];
    try {
      if(usertype=='STUDENT')
        {
          await profileList.doc('India').collection('IIITA').doc('Profile')
              .collection('Student').get().then((querySnapshot) {
            querySnapshot.docs.forEach((element) {
              print(element.data());
              itemsList.add(element.data());
            });
          });
          return itemsList;
        }
      else
        {
          await profileList.doc('India').collection('IIITA').doc('Profile')
              .collection('Admin-Faculty').get().then((querySnapshot) {
            querySnapshot.docs.forEach((element) {
              print(element.data());
              itemsList.add(element.data());
            });
          });
          return itemsList;
        }



    } catch (e) {
      print(e.toString());
      return null;
    }
  }




  Future getUsersList2(String usertype) async {
   List itemsList=[] ;
    try {
      if(usertype=='UserType.STUDENT') {
        await profileList.doc('India').collection('IIITA').doc('Profile')
            .collection('Student').doc(
            locator<AuthenticationServices>().firebaseUser.uid.toString()).get()
            .then((element) {
          itemsList.add(element.data());
          print(element.data());
        });
        return itemsList;
      }
      else
        {
          await profileList.doc('India').collection('IIITA').doc('Profile')
              .collection('Admin-Faculty').doc(
              locator<AuthenticationServices>().firebaseUser.uid.toString()).get()
              .then((element) {
            itemsList.add(element.data());
            print(element.data());
          });
          print(itemsList);
          return itemsList;

        }


    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List> getCourseList( String semester) async {
    List itemsList = [];
    try {

        await profileList.doc('India').collection('IIITA').doc('Courses')
            .collection('Btech').doc('IT').collection(semester).get().then((querySnapshot) {
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
  Future<List> getAddOnList() async {
    List itemsList = [];
    try {

      await profileList.doc('India').collection('IIITA').doc('Courses')
          .collection('Addon').get().then((querySnapshot) {
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


  Future<List> getCourseList2( String id) async {
    List itemsList = [];
    try {

      await profileList.doc('India').collection('IIITA').doc('CourseSelected')
          .collection('Btech-IT').doc(id).collection('core').get().then((querySnapshot) {
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

  Future<List> getAddOnList2(String id) async {
    List itemsList = [];
    try {

      await profileList.doc('India').collection('IIITA').doc('CourseSelected')
          .collection('Btech-IT').doc(id).collection('Addon').get().then((querySnapshot) {
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

  Future<void> createAddOnData(String a, String name, String id, String instructor) async {

      return await profileList.doc('India').collection('IIITA').doc('CourseSelected')
          .collection('Btech-IT').doc(a).collection('Addon').doc(name).set({
        'name': name,
        'id':id,
        'instructor': instructor,
      });
    }

  Future<void> createCourseData(String a, String name, String id, String instructor, String credit) async {

    return await profileList.doc('India').collection('IIITA').doc('CourseSelected')
        .collection('Btech-IT').doc(a).collection('core').doc(name).set({
      'name': name,
      'id':id,
      'instructor': instructor,
      'credit': credit,
    });
  }

  SharedPreferencesHelper _sharedPreferencesHelper =
  locator<SharedPreferencesHelper>();
  Future<void> cregister(String id) async {

    return await profileList.doc('India').collection('IIITA').doc('CRegister')
        .collection('Btech').doc(id).set({
        'id':id,
    });
  }

  Future<void> cregisterupdate(String id) async {
    String s= await _sharedPreferencesHelper.getLoggedInUserId();
    return await profileList.doc('India').collection('IIITA').doc('CRegister')
        .collection('Btech').doc(s).delete();
  }

  Future<void> courseregsitrationedit(String id) async {
    String s= await _sharedPreferencesHelper.getLoggedInUserId();
    return await profileList.doc('India').collection('IIITA').doc('CourseSelected')
        .collection('Btech-IT').doc(s).collection('Addon').get().then((querySnapshot) {
         querySnapshot.docs.forEach((element) {
         element.data().clear();
      });
    });
  }

  Future<void> courseregsitrationedit2(String id) async {
    String s= await _sharedPreferencesHelper.getLoggedInUserId();
    return await profileList.doc('India').collection('IIITA').doc('CourseSelected')
        .collection('Btech-IT').doc(s).collection('core').get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        element.data().clear();
      });
    });
  }


  Future<int> isthere(String id) async {
    return await profileList.doc('India').collection('IIITA').doc('CourseSelected')
        .collection('Btech-IT').get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data());
        if(element.data().containsKey(id)) return 1 ;
        else return 0;
      });
    });;
  }

  Future<List> getRegisterList() async {
    List itemsList = [];
    try {

      await profileList.doc('India').collection('IIITA').doc('CRegister')
          .collection('Btech').get().then((querySnapshot) {
        querySnapshot.docs.forEach((element)
        {
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