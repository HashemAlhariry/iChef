import 'package:firebase_auth/firebase_auth.dart';
import 'package:ichef/models/user.dart';

class AuthService{

  final FirebaseAuth _auth =FirebaseAuth.instance;


  // user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid) : null ;
  }

  // sign in anon
  Future signInAnon() async{
    try{
      AuthResult authResult =  await _auth.signInAnonymously();
      FirebaseUser user =authResult.user;
      return _userFromFirebaseUser(user);
    }catch(e){
        print(e.toString());
        return null;
    }
  }

  // sign in  with email & password



  // register with email and password


  // sign out

}