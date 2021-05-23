import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String idd;
  String photoUrl;
  String email;
  String division;
  String id;
  String enrollNo;
  String firebaseUuid;
  String displayName;
  String standard;
  String dob;
  String guardianName;
  String bloodGroup;
  String mobileNo;
  bool isTeacher;
  bool isVerified;
  // Map<String, dynamic> connection;
  var connection;

  String standardDivision() {
    return standard + division.toUpperCase();
  }

  AppUser(
      {
        this.idd ='',
        this.photoUrl = 'default',
      this.email = '',
      this.division = '',
      this.id = '',
      this.enrollNo = '',
      this.firebaseUuid = '',
      this.connection = null,
      this.displayName = '',
      this.standard = '',
      this.dob = '',
      this.guardianName = '',
      this.bloodGroup = '',
      this.mobileNo = '',
      this.isTeacher = false,
      this.isVerified = false}
      );

  bool isEmpty() {
    if (this.displayName == '') return true;

    if (this.division == '') return true;

    if (this.standard == '') return true;

    if (this.guardianName == '') return true;

    return false;
  }

  AppUser.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _fromJson( documentSnapshot.data());
  }

  _fromJson( dynamic json) {
    idd = json['name'] ?? '';
    photoUrl = json['photoUrl'] ?? 'default';
    email = json['email'] ?? '';
    division = json['section'] ?? '';
    id = json['id'] ?? '';
    enrollNo = json['enrollNo'] ?? '';
    firebaseUuid = json['firebaseUuid'] ?? '';
    displayName = json['displayName'] ?? '';
    standard = json['batch'] ?? '';
    dob = json['dob'] ?? '';
    guardianName = json['guardianName'] ?? '';
    bloodGroup = json['bloodGroup'] ?? '';
    mobileNo = json['mobileNo'] ?? '';
    isTeacher = json['isTeacher'] ?? false;
    isVerified = json['isVerified'] ?? false;
    connection = json['connection'] ?? {};
  }

  AppUser.fromJson(dynamic json) {
    _fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idd'] = this.idd;
    data['photoUrl'] = this.photoUrl;
    data['email'] = this.email;
    data['section'] = this.division.toUpperCase().trim();
    data['id'] = this.id;
    data['enrollNo'] = this.enrollNo;
    data['firebaseUuid'] = this.firebaseUuid;
    data['displayName'] = this.displayName;
    data['batch'] = this.standard;
    data['dob'] = this.dob;
    data['guardianName'] = this.guardianName;
    data['bloodGroup'] = this.bloodGroup;
    data['mobileNo'] = this.mobileNo;
    data['isTeacher'] = this.isTeacher;
    data['isVerified'] = this.isVerified;
    data['connection'] = this.connection;
    return data;
  }
}


