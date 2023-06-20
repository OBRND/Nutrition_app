import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/Place_order/placeOrderPages.dart';
import 'package:gebeta/Screens/bottomNav.dart';
import 'package:gebeta/Services/Auth.dart';
import 'package:gebeta/Services/Notification.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'Screens/Wrapper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeNotifications();
  NotificationHelper().initializeNotification();
  tz.initializeTimeZones();
  NotificationHelper().scheduledNotification(hour: 12, minutes: 42, id: 01);
  runApp(const MyApp());
}


Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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