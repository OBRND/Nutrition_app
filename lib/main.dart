import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/Place_order/placeOrderPages.dart';
import 'package:gebeta/Screens/bottomNav.dart';
import 'package:gebeta/Services/Auth.dart';
import 'package:provider/provider.dart';

import 'Screens/Wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return StreamProvider<UserFB?>.value(
        value: Auth_service().Userx,
        initialData: null,
        child: MaterialApp(
          // home: Home(),
          home: wrapper(),
          routes: {
            '/place': (context) => BottomTab(index: 1),
           },
        )
    );
  }
}