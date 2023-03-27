import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gebeta/Model/Decorations.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formkey = GlobalKey<FormState>();
  String Uid = '';
  String first = '';
  String last = '';
  String phone = '';
  int i = 0;
  String error = '';
  List gender = ["Male","Female"];
  String weight = '';
  String height = '';
  String select = 'Male';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Profile', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black,)),
        ),
        body: Container(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // padding: EdgeInsets.all(10),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height *.1,),
                  ClipOval(
                    child: CircleAvatar(
                      child: Image.asset(select == 'Male' ? 'Assets/img.png' :'Assets/img_1.png' ),
                      radius: 40,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Your profile info',
                    style: TextStyle(fontSize: 18, color: Colors.black),),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Choose gender  ',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                        addRadioButton(0, 'Male'),
                        addRadioButton(1, 'Female'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      decoration: textinputdecoration.copyWith(hintText: 'First name'),
                      validator: (val) => val!.length < 4 ? 'Enter a valid first name' : null,
                      // obscureText: true,
                      onChanged: (val){
                        setState(() => first = val);
                      }
                  ),
                  SizedBox(height: 4,),
                  TextFormField(
                      decoration: textinputdecoration.copyWith(hintText: 'Last name'),
                      validator: (val) => val!.length <4 ? 'Enter a valid last name' : null,
                      // obscureText: true,
                      onChanged: (val){
                        setState(() => last = val);
                      }
                  ),
                  SizedBox(height: 4,),
                  TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: 'Phone number'),
                    // obscureText: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (val){
                      if (isphonevalid (val)) {
                        setState(() => phone = val);
                      }
                    },
                    validator: (val) => isphonevalid(val!) ? null: 'Enter a valid phone number',

                  ),
                  TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: 'Your weight'),
                    // obscureText: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (val){
                      if (isphonevalid (val)) {
                        setState(() => weight = val);
                      }
                    },
                    validator: (val) => double.parse(val!) < 300  ? null: 'Enter a valid phone number',

                  ),
                  TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: 'Your height'),
                    // obscureText: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (val){
                      if (isphonevalid (val)) {
                        setState(() => height = val);
                      }
                    },
                    validator: (val) => double.parse(val!) < 300  ? null: 'Enter a valid phone number',

                  ),


                  TextButton(
                      onPressed: () async{
                        // if(_formkey.currentState!.validate()){
                          //   setState(() => loading =
                          // dynamic result = await DatabaseService(uid: user.uid).updateUserData(first,last, phone);
                          // dynamic result = await _auth.registerWEP(email, password,First_name, Last_name, Phone_number);
                        //   if(result == null){
                        //     setState((){error ='Success!';
                        //     });
                        //   } else{
                        //     setState((){  error ='Sorry, an error occured, try again later';
                        //     });
                        //   }
                        // }
                        // print(await databaseservice.getuserInfo());
                        // List Profile = await databaseservice.getuserInfo();
                        //  setState((){
                        //    first = Profile[0];
                        //    last = Profile[1];
                        //    phone = Profile[2];
                        //  });
                      },
                      child: Text("Edit data")
                  ),
                  Text(error,
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value){
            setState(() {
              print(value);
              select=value;
            });
          },
        ),
        Text(title)
      ],
    );
  }
  //Use the above widget where you want the radio button


  bool isphonevalid(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = new RegExp(regexPattern);

    if (phoneNumber.length == 0) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

}
