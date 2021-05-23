import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';

import '../../../locator.dart';

class DatabaseManager {
  final CollectionReference profileList =
  FirebaseFirestore.instance.collection('Colleges');

  Future<List> getStdList() async {
    List itemsList = [];
    try {
      await profileList.doc('India').collection('IIITA').doc('Profile').collection('Student').get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          print('gotttttttt ittttttttt');
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