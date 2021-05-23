import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class FireStorageService extends ChangeNotifier {
  FireStorageService._();
  FireStorageService();

  static Future<dynamic> loadFromStorage(
      BuildContext context, String image) async {
    print(image);
    print("eeeeeeeeeeeeeeeeeeeeeeeeeee");
    // print(FirebaseStorage.instance.ref());
    // if(FirebaseStorage.instance.ref().child(image)==Null)print("not found");
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref().child(image);
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(image)
        .getDownloadURL();
    print(downloadURL);
    return downloadURL;
  }
}