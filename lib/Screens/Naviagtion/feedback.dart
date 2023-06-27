import 'package:flutter/material.dart';
import 'package:gebeta/Model/Decorations.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/bottomNav.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:provider/provider.dart';

class feedback extends StatefulWidget {
  const feedback({Key? key}) : super(key: key);

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {

  String feedback = '';
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);

    return Scaffold(
      backgroundColor: Color(0xffecebe9),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Feedback'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Thank you for using our app! We value your opinion and would love to hear your feedback.'
                  ' Your insights help us improve and deliver a better user experience. '
                  'Please take a moment to share your thoughts, suggestions, or any issues you encountered while using our app.'
                  ' Your feedback is crucial in shaping our future updates.\n\n We appreciate your time and contribution!',
              textAlign: TextAlign.justify,
              style:  TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400),),
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: 'Enter your message here',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54, width: 2),
                        )),
                    maxLines: 7,
                    validator: (val) => val!.isEmpty ? 'Please enter a message before sending' : null,
                    onChanged: (val){
                        setState(() => feedback = val);
                    }
                ),
              ),
            ),
            Positioned(
              child: ElevatedButton(onPressed: () async{
                if(_formkey.currentState!.validate()) {
                  await DatabaseService(uid: user!.uid).feedback(feedback);
                  SnackBar snackBar = SnackBar(
                    backgroundColor: Colors.black54.withOpacity(.6),
                    content: Text('Feedback succesfully sent', style:  TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w400),),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white70),),
                  ),
                  child: Text('Submit feedback')),
            ),
          ],
        ),
      ),
    );
  }
}
