import 'package:country_code_picker/country_code_picker.dart';
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
  String Ctrycode = '';

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
                            setState(() => email = val.trim());
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
                      Row(
                        children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * .3,
                          child: CountryCodePicker(
                          onChanged: (countryCode){
                            setState(() {
                              Ctrycode= countryCode.toString();
                            });
                          },
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: 'ET',
                          favorite: ['+39','FR'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,
                      ),
                        ),
                          Container(
                            width: MediaQuery.of(context).size.width * .6,
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: textinputdecoration.copyWith(hintText: 'eg. 91 101 0101'),
                                validator: (val) => val!.length < 9 || val!.length > 10 ? 'Please enter a valid phone number ' : null,
                                onChanged: (val){
                                  setState(() => Phone_number = val );
                                }
                            ),
                          ),
                        ],
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
                              dynamic result = await _auth.registerWEP(email, password,First_name, Last_name, (Ctrycode + Phone_number), context);
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