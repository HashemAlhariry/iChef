import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:ichef/services/auth.dart';
import 'package:ichef/shared/constants.dart';
import 'package:ichef/shared/loading.dart';

class Login extends StatefulWidget {

  final Function toggleView;
  Login({this.toggleView});
  @override
  _State createState() => _State();
}

class _State extends State<Login> {

  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading=false;

  String error ='';
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Colors.red[400],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal:20.0),
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
                    key: _formkey,
                    child: Column(
                       children: <Widget>[
                         SizedBox(height: 20.0),
                         TextFormField(
                           decoration: textInputDecoration.copyWith(hintText: "Email"),
                           validator: (val) => val.isEmpty ? 'Enter an email' : null,
                           onChanged: (val) {
                             setState(() => email = val);
                           },
                         ),
                         SizedBox(height: 20.0),
                         TextFormField(
                           validator: (val) => val.length < 6 ? 'Enter a password more than 6 characters' : null,
                           obscureText: true,
                           decoration:textInputDecoration.copyWith(hintText: "Password"),
                           onChanged: (val) {
                             setState(() => password = val );
                           },
                         ),
                         SizedBox(height: 20.0),
                         RaisedButton(
                           textColor: Colors.white,
                           color: Colors.blue,
                           child: Text('Login'),
                           onPressed: () async {
                             if (_formkey.currentState.validate()) {
                               setState(() => loading=true);
                               email=email.trim();
                               dynamic result = await _authService.logInWithEmailAndPassword(email, password);
                               print(email+ " " + password);
                               if(result==null){
                                setState(() {
                                  loading=false;
                                  error='Couldn\'t Sign in with email or password';
                                 });
                                }
                             }
                           },
                         ),
                         SizedBox(height: 15.0,),
                         Text(error,style: TextStyle(color:Colors.red,fontSize: 14.0,),textAlign: TextAlign.center,),
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
                       dynamic result = await _authService.signInAnon();
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

                SizedBox(height: 10.0),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Doesn\'t you have account'),
                        FlatButton.icon(
                          icon:Icon(Icons.person),
                          textColor: Colors.blue,
                          label: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            widget.toggleView();
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),

              ],
            )));
  }
}
