import 'package:flutter/material.dart';
import 'package:gebeta/Authentication/Sign_in.dart';
import 'package:gebeta/Screens/bottomNav.dart';
import 'package:provider/provider.dart';

import '../Model/User.dart';
import 'Home.dart';

class wrapper extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserFB?>(context);
    print(user);
    if (user == null){
      return Sign_in();
    } else {
      return BottomTab(index: 1);
    }
  }

}