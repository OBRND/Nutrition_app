import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gebeta/Authentication/Sign_in.dart';
import 'package:gebeta/Model/Decorations.dart';
import 'package:gebeta/Services/Auth.dart';

class Sign_up extends StatefulWidget {
  // const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

  final Auth_service _auth = Auth_service();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String First_name ='';
  String Last_name ='';
  String Phone_number = '';
  String error ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      // backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(child: Text('New to Gebeta ?', style: TextStyle(color: Colors.black),)),
        elevation: 0,
        actions: [
        ],),
      body: Stack(
        children:[
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox( height: 20),
                      TextFormField(
                          decoration: textinputdecoration.copyWith(hintText: 'Email'),
                          validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val){
                            setState(() => email = val);
                          }

                      ),
                      SizedBox( height: 10),
                      TextFormField(
                          decoration: textinputdecoration.copyWith(hintText: 'Password'),
                          validator: (val) => val!.length < 6 ? 'Enter password more that 6 characters' : null,
                          obscureText: true,
                          onChanged: (val){
                            setState(() => password = val);
                          }
                      ),
                      SizedBox( height: 10),
                      TextFormField(
                          decoration: textinputdecoration.copyWith(hintText: 'First Name'),
                          validator: (val) => val!.isEmpty ? 'Enter First' : null,
                          onChanged: (val){
                            setState(() => First_name = val);
                          }
                      ),
                      SizedBox( height: 10),
                      TextFormField(
                          decoration: textinputdecoration.copyWith(hintText: 'Last Name'),
                          validator: (val) => val!.isEmpty ? 'Enter Last name' : null,
                          onChanged: (val){
                            setState(() => Last_name = val);
                          }
                      ),
                      SizedBox( height: 10),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: textinputdecoration.copyWith(hintText: 'Phone number'),
                          validator: (val) => val!.length == 10 ?   null : 'Please enter a 10 digit phone number ',
                          onChanged: (val){
                            setState(() => Phone_number = val );
                          }
                      ),
                      SizedBox( height: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape:
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white54),),
                          backgroundColor: Colors.green),
                          child: Text("Sign up",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async{
                            if(_formKey.currentState!.validate()){
                              //   setState(() => loading = true);
                              dynamic result = await _auth.registerWEP(email, password,First_name, Last_name, Phone_number);
                              if(result == null){
                                setState((){ error ='please supply a valid email';
                                  //     loading = false;
                                });
                              }
                            }
                          }
                      ),

                      SizedBox( height: 0),
                      Text(error,
                          style: TextStyle(color: Colors.red)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextButton(onPressed:(){
                         Navigator.of(context).pushReplacement(MaterialPageRoute(
                             builder: (context) =>  Sign_in()));
                        },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),),
                          backgroundColor: Colors.transparent,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back),
                            Text(' Return to Log in',style: TextStyle(color:Colors.blueAccent,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      //   );
      // }
    );
  }
}