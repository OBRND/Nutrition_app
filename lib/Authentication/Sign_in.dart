import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gebeta/Authentication/Sign_up.dart';
import 'package:gebeta/Model/Decorations.dart';
import 'package:gebeta/Services/Auth.dart';

class Sign_in extends StatefulWidget {

  @override
  State<Sign_in> createState() => _Sign_inState();
}
class _Sign_inState extends State<Sign_in> {

  final Auth_service _auth= Auth_service();
  final _formkey = GlobalKey<FormState>();
  //text field states
  String email = '';
  String password = '';
  String error ='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  //loading ? Loading()
      backgroundColor: Colors.orange,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [SizedBox( height: MediaQuery.of(context).size.height*0.25),
              Text('Gebeta \n'
                  'Nutritioun!', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white70),),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              TextFormField(
                  decoration: textinputdecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  }
              ),
              SizedBox( height: 20),
              TextFormField(
                  decoration: textinputdecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val!.length <6 ? 'Enter password more than 6 characters' : null,

                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  }
              ),
              SizedBox( height: 20),
              Text(error,
                style: TextStyle(color: Colors.red),
              ),
              ElevatedButton(
                // color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 5),
                    child: Text("Log in",
                      style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff108338),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color.fromARGB(255, 231, 133, 53)),),
                  ),
                  onPressed: () async{
                    if(_formkey.currentState!.validate()){
                      dynamic result = await _auth.Signin_WEP(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Could not sign in with those credentials';
                          // loading = false;
                        });
                      }
                    }
                  }
              ),
              // RaisedButton(onPressed: () async{
              //   dynamic result = await _auth.signInAnnon();
              //   print(result);
              // },child: Text('Annonymous'),),
              SizedBox( height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text('Don\'t have an account yet?  ',
                        style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w400, fontSize: 17)),
                    TextButton(onPressed:(){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Sign_up()));
              },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent
                ),
                child: Text('Sign up', style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500, fontSize: 20),),
              ),])
            ],
          ),
        ),
        // child: RaisedButton(
        //   child: Text('Sign in Anonymously'),
        // onPressed: () async{
        //   await Firebase.initializeApp();
        //   final authservice _auth = authservice();
        //     await _auth.signInAnnon();
        //     dynamic result = await _auth.signInAnnon();
        //     if(result == null){
        //       print('Error signing in');
        //     } else {
        //       print('signed in');
        //       print(result.uid);
        //     }
        // }
        // ),
      ),
    );
  }
}
