import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection = Firestore.instance.collection('users');

  Future updateUserData ( String mobileNumber, String email, String address, String age) async
  {
    return await usersCollection.document(uid).setData(
      {
            'phone_number':mobileNumber,
            'email':email,
            'address':address,
            'age':age,
      });
  }





}