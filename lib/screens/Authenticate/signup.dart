import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:ichef/services/auth.dart';
import 'package:ichef/shared/constants.dart';
import 'package:ichef/shared/loading.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _State createState() => _State();
}

class _State extends State<SignUp> {

  String email = '';
  String password = '';
  String retryPassword = '';
  String mobile = '';
  String address = '';
  String age= '';
  String error= '';

  final AuthService _authService= AuthService();
  final _formkey = GlobalKey <FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          backgroundColor: Colors.red[400],
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
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
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
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
                              decoration:textInputDecoration.copyWith(hintText: "Password"),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (val)
                              {
                                if( val == password && val.length >=6)
                                  {
                                    return null;
                                  }
                                if( val != password )
                                {
                                  return 'password didn\'t match';
                                }
                                return 'Enter a password more than 6 characters';
                              },
                              decoration:textInputDecoration.copyWith(hintText: "Retry password"),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => retryPassword = val);
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (val) => val.length == 11  ?  null : 'Enter your mobile number',
                              decoration: textInputDecoration.copyWith(hintText: "Mobile number"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              onChanged: (val) {
                                setState(() => mobile = val);
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (val) => int.parse(val)> 5 && int.parse(val) < 125   ?  null : 'Enter your age right',
                              decoration: textInputDecoration.copyWith(hintText: "age"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              onChanged: (val) {
                                setState(() => age = val);
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: "Address"),
                              onChanged: (val) {
                                setState(() => address = val);
                              },
                            ),
                            SizedBox(height: 20.0),

                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              child: Text('Sign up'),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() => loading=true);
                                  dynamic result = await _authService.signUpWithEmailAndPassword(email, password,mobile,age,address);
                                  if(result==null){
                                        setState(() {
                                          loading=false;
                                          error='Please enter valid email';
                                        });
                                  }
                                }
                              },
                            )

                          ],
                        ))),
                SizedBox(height: 15.0,),
                Text(error,style: TextStyle(color:Colors.red,fontSize: 14.0,),textAlign: TextAlign.center,),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Do you have account?'),
                        FlatButton.icon(
                          icon: Icon(Icons.person),
                          textColor: Colors.blue,
                          label: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            widget.toggleView();
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))

              ],
            )));
  }
}
