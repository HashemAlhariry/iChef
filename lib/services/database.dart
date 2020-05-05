import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ichef/models/recipe.dart';
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection = Firestore.instance.collection('users');
  final CollectionReference recipesCollection = Firestore.instance.collection('recipes');


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


  // get recipes stream
  Stream <QuerySnapshot> get recipes {
    return recipesCollection.snapshots();
  }








}