import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:ichef/services/auth.dart';

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final AuthService _auth = AuthService();

 /*
  void firebaseLogin() async {
    try {
      AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (auth.user != null)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (cont) {
              return ForgetPassword();
            },
          ),
        );
    } catch (error) {
      print("Erorr in login function");
    }
  }

  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Colors.red,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'iChef',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 40),
                    )),
                Container(
                  child:Form(
                    child: Column(
                       children: <Widget>[
                          Container(
                             padding: EdgeInsets.all(10),
                             child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                          ),

                         Container(
                           padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                           child: TextField(
                             obscureText: true,
                             controller: passwordController,
                             decoration: InputDecoration(
                               border: OutlineInputBorder(),
                               labelText: 'Password',
                             ),
                           ),
                         ),
                         Container(
                             height: 50,
                             padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                             margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                             child: RaisedButton(
                               textColor: Colors.white,
                               color: Colors.blue,
                               child: Text('Login'),
                               onPressed: () {
                                 // print("Here");
                                 //firebaseLogin();
                                 print(emailController.text);
                                 print(passwordController.text);
                               },
                             )),

                       ],
                    ))),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 40,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Sign in Anonymous'),
                      onPressed: () async {
                       dynamic result = await _auth.signInAnon();
                       if(result==null)
                         {
                           print('Error Signing in');
                         }
                       else{
                         print('Signed in ');
                         print(result.uid);

                       }
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: SignInButton(Buttons.Facebook,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        onPressed: () {})),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: SignInButton(Buttons.GoogleDark,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      onPressed: () {}),
                ),
              ],
            )));
  }
}
