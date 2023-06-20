import 'package:flutter/material.dart';
import 'package:gebeta/Model/Recipee.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/Ingridients.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class Custom_Plan extends StatefulWidget {
  const Custom_Plan({Key? key}) : super(key: key);

  @override
  State<Custom_Plan> createState() => _Custom_PlanState();
}

class _Custom_PlanState extends State<Custom_Plan> {
  int _selectedIndex = DateTime.now().weekday - 1;
  int _selectedDate = DateTime.now().day;
  final List<String> _daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  int sltdted = 0;
  List<Recipee> selected = [];
  List plan = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> scheduleNotifications() async {
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

    // Clear any previously scheduled notifications
    await flutterLocalNotificationsPlugin.cancelAll();

    // Schedule notifications
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Unique ID for each notification
      'Breakfast Time', // Notification title
      'It\'s time for breakfast!', // Notification content
      _nextInstanceOf(7, 0), // 7 AM
      platformChannelSpecifics,
      androidAllowWhileIdle: true, // Allow notification to be shown even if the device is in idle/doze mode
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1, // Unique ID for each notification
      'Lunch Time', // Notification title
      'It\'s time for lunch!', // Notification content
      _nextInstanceOf(13, 07 ), // 12 PM
      platformChannelSpecifics,
      androidAllowWhileIdle: true, // Allow notification to be shown even if the device is in idle/doze mode
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2, // Unique ID for each notification
      'Dinner Time', // Notification title
      'It\'s time for dinner!', // Notification content
      _nextInstanceOf(18, 00), // 6 PM
      platformChannelSpecifics,
      androidAllowWhileIdle: true, // Allow notification to be shown even if the device is in idle/doze mode
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future getPlan(user) async{
    int plandate = 0;
    plan = await DatabaseService(uid: user).getPlan();
    print(plan);
    print(DateFormat('dd/MM/yyyy').format(DateTime.now()));
    if(_selectedIndex == DateTime.now().weekday - 1){
    for (var element in plan) {
      if(DateFormat('dd/MM/yyyy').format(DateTime.now()) == element['date']){
        sltdted = plandate;
        plandate++;
        print('Found');
        Recipee recipeeBreakfast = await DatabaseService(uid: user).getrecipee(element['breakfast']);
        Recipee recipeeLunch = await DatabaseService(uid: user).getrecipee(element['lunch']);
        Recipee recipeeDinner = await DatabaseService(uid: user).getrecipee(element['dinner']);
        selected = [recipeeBreakfast, recipeeLunch, recipeeDinner];
        print(selected);
      }else {
        plandate++;
        print(plandate);
      }
    };
    }
    return plan;
  }



  Future<List<Recipee>> updateMealPlan(user) async {
    // Get the selected date based on the _selectedIndex
    DateTime selectedDate = DateTime.now().add(Duration(days: _selectedIndex - DateTime.now().weekday + 1));

    String selectedDateFormat = DateFormat('dd/MM/yyyy').format(selectedDate);
    List<Recipee> updatedPlan = [];

    for (var element in plan) {
      if (element['date'] == selectedDateFormat) {
        print(element['breakfast']);
        print(element['lunch']);
        print(element['dinner']);
        Recipee recipeeBreakfast = await DatabaseService(uid: user).getrecipee(element['breakfast']);
        Recipee recipeeLunch = await DatabaseService(uid: user).getrecipee(element['lunch']);
        Recipee recipeeDinner = await DatabaseService(uid: user).getrecipee(element['dinner']);

        updatedPlan = [recipeeBreakfast, recipeeLunch, recipeeDinner];
        break;
      }
    }

    // Update the meal plan with the updatedPlan
    setState(() {
      selected = updatedPlan;
    });
    return updatedPlan;
  }

  @override
  void initState() {
    scheduleNotifications();
    // NotificationHelper().scheduledNotification(hour: 9, minutes: 57, id: 01);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    List<DateTime> weekDays = List.generate(
        7, (index) => startOfWeek.add(Duration(days: index)));

    while (weekDays[0].month != now.month) {
      startOfWeek = startOfWeek.add(Duration(days: 7));
      weekDays =
          List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
    }

    return Scaffold(
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: DatabaseService(uid: user!.uid).getuserInfo(),
                        builder: (context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Text('Hello',
                                style: TextStyle(fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),);
                          // case (ConnectionState.done) :
                            default:
                              return Text('Hello, ${ snapshot.data[0]}',
                                style: TextStyle(fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),);
                          }
                        }),
                    Text('check out what\'s for today', style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w300),),
                  ],
                ),
              ),
            ),
            Container(
              height: 62,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _daysOfWeek.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async{
                      _selectedIndex = index;
                      await updateMealPlan(user.uid);
                      setState(() {
                        // _selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: 50,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      padding: EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        color: index == _selectedIndex ? Colors
                            .lightGreen : Colors
                            .grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Column(
                            children: [
                              Text(weekDays[index].day.toString(),
                                style: TextStyle(fontSize: 20,
                                  fontWeight: index == _selectedIndex
                                      ? FontWeight.bold
                                      : FontWeight.w300,
                                  color: index == _selectedIndex
                                      ? Colors.white
                                      : Colors.black,
                                ),),
                              // Text( index < _selectedIndex && _selectedDate + index < 31 && _selectedDate + index > 0 ? (_selectedDate - _selectedIndex).toString():
                              // index > _selectedIndex && _selectedDate + index < 31 ? (_selectedDate + index).toString() :
                              // _selectedDate + index == 31 ? '0' : _selectedDate.toString() ),
                              Text(
                                _daysOfWeek[index],
                                style: TextStyle(fontSize: 12,
                                  fontWeight: index == _selectedIndex
                                      ? FontWeight.bold
                                      : FontWeight.w300,
                                  color: index == _selectedIndex
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: FutureBuilder(
                  future: getPlan(user.uid),
                  builder: (context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .2),
                            child: Text('Loading your meals...',
                              style: TextStyle(fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),),
                          ),
                        );
                    // case (ConnectionState.done) :
                      default:
                        return
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Breakfast', style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.brown),),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: InkWell(
                                      onTap: () {
                                        List<Ingredient> ingredientList = [];
                                        for (int i = 0; i < selected[0].ingredients.length; i++) {
                                          print(selected[0].ingredients[i]['Measurement']);
                                          ingredientList.add(
                                            Ingredient(
                                                name: selected[0].ingredients[i]['label'],
                                                calories: selected[0].ingredients[i]['calories'],
                                                amount: selected[0].ingredients[i]['Measurement']),
                                          );
                                        }
                                        print('----------------');
                                        print(selected[0].ingredients[0]['label']);

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    IngredientsPage(
                                                      foodName: selected[0].name,
                                                      imageURL: selected[0].imageURL,
                                                      ingredients: ingredientList,
                                                      totalCalories: 0,
                                                    )));
                                      },
                                      child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Container(height: 100,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(20)
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(10),
                                                                bottomLeft: Radius.circular(10)),
                                                            child: Image.network('selected[0].imageURL',
                                                              fit: BoxFit.fitWidth,))),
                                                    Container(
                                                      height: 80,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(selected[0].name,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight
                                                                    .w500),),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Cooking time - ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight: FontWeight
                                                                        .w700,
                                                                    fontSize: 14),),
                                                              Text(selected[0].cookingTime.toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize: 12),),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10,),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ]),
                                    )

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Lunch', style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.brown),),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: InkWell(
                                      onTap: () {
                                        List<Ingredient> ingredientList = [];
                                        for (int i = 0; i < selected[1].ingredients.length; i++) {
                                          print(selected[1].ingredients[i]['Measurement']);
                                          ingredientList.add(
                                            Ingredient(
                                                name: selected[1].ingredients[i]['label'],
                                                calories: selected[1].ingredients[i]['calories'],
                                                amount: selected[1].ingredients[i]['Measurement']),
                                          );
                                        }
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    IngredientsPage(
                                                      foodName: selected[1].name,
                                                      imageURL: selected[1].imageURL,
                                                      ingredients: ingredientList,
                                                      totalCalories: 750,
                                                    )));
                                      },
                                      child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Container(height: 100,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(20)
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(10),
                                                                bottomLeft: Radius.circular(10)),
                                                            child: Image.network(selected[1].imageURL,
                                                              fit: BoxFit.fitWidth,))),
                                                    Container(
                                                      height: 80,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(selected[1].name,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight
                                                                    .w500),),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Cooking time - ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight: FontWeight
                                                                        .w700,
                                                                    fontSize: 14),),
                                                              Text(selected[1].cookingTime.toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize: 12),),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10,),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ]),
                                    ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Dinner', style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.brown),),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: InkWell(
                                      onTap: () {
                                        List<Ingredient> ingredientList = [];
                                        for (int i = 0; i < selected[2].ingredients.length; i++) {
                                          print(selected[2].ingredients[i]['Measurement']);
                                          ingredientList.add(
                                            Ingredient(
                                                name: selected[2].ingredients[i]['label'],
                                                calories: selected[2].ingredients[i]['calories'],
                                                amount: selected[2].ingredients[i]['Measurement']),
                                          );
                                        }
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    IngredientsPage(
                                                      foodName: selected[2].name,
                                                      imageURL: selected[2].imageURL,
                                                      ingredients: ingredientList,
                                                      totalCalories: 230,
                                                    )));
                                      },
                                      child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Container(height: 100,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(20)
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(10),
                                                                bottomLeft: Radius.circular(10)),
                                                            child: Image.network(selected[2].imageURL,
                                                              fit: BoxFit.fitWidth,))),
                                                    Container(
                                                      height: 80,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(selected[2].name,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight
                                                                    .w500),),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Cooking time - ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight: FontWeight
                                                                        .w700,
                                                                    fontSize: 14),),
                                                              Text(selected[2].cookingTime.toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize: 12),),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10,),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ]),
                                    )

                                ),

                              ],
                            ),
                          );
                    }
                  }
              ),
            ),
          ],
        ),

        // color: Colors.orange,
      ),

    );
  }
}
