import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createBrand(String name){
    var id = Uuid();
    String brandId = id.v1();

    _firestore.collection('Colleges').doc('India').collection('IIITA').doc('Courses').collection(name).doc('1').set({'Courses': name});
  }
}