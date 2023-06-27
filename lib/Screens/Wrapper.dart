import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gebeta/Authentication/Sign_in.dart';
import 'package:gebeta/Screens/bottomNav.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:gebeta/Services/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Model/User.dart';
import 'Home.dart';

class wrapper extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future sendWarningNotification(uid) async{
    String endDate = await DatabaseService(uid: uid).getlastdate();
    if(isWithinSevenDays(endDate)){
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        // 'channel_description',
        importance: Importance.high,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        002, // Unique ID for the notification
        'Your meal plan is about to end!',
        'You plan has less than a few days to end!',
        platformChannelSpecifics,
        payload: 'notification_payload',
      );
    };
  }

  bool isWithinSevenDays(String dateStr) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final currentDate = DateTime.now();
    final targetDate = dateFormat.parse(dateStr);

    final difference = targetDate.difference(currentDate).inDays.abs();

    return difference < 7;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    print(user);
    if (user == null){
      return Sign_in();
    } else {
      return ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(uid: user.uid),
        builder: (context, _) {
          sendWarningNotification(user?.uid);
          final userProvider = Provider.of<UserProvider>(context, listen: false);
         return FutureBuilder(
          future: userProvider.loadUserData(),
          builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          return Container(
            color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gebeta', style: TextStyle(
                            color: Color(0xff5a7046), fontSize: 25)),
                        Text('           Nutrition', style: TextStyle(
                            color: Color(0xffb9a674), fontSize: 16))
                      ]),
                  CircularProgressIndicator(color: Colors.green,),
                ],
              )));
          default:
            return BottomTab(index: 1);
          }
          });
        },
      );
    }
  }

}