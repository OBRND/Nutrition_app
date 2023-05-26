import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gebeta/Model/Goal.dart';
import 'package:gebeta/Screens/toast.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../Model/User.dart';
import '../Services/Database.dart';

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}

double percentage = 0.75;
// int intake = 1900;

class _ProgressState extends State<Progress> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController goalController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  DateTime? pickedDate;
  String? _dateError;
  List<Map<String, dynamic>> goals = [];


  @override
  void dispose() {
    goalController.dispose();
    rewardController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getgoals();
    super.initState();
  }

  Future getgoals() async{
    final user = FirebaseAuth.instance.currentUser!;
    List<Map<String, dynamic>> fbgoals = await DatabaseService(uid: user!.uid).getgoals();
    setState(() {
      goals = fbgoals;
    });
  }

  double calculateGoalPercentage(List<Map<String, dynamic>> goals) {
    if (goals.isEmpty) {
      return 0.0;
    }

    final int totalGoals = goals.length;
    final int achievedGoals = goals.where((goal) => goal['achieved'] == true).length;

    return (achievedGoals / totalGoals);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    double percentage = calculateGoalPercentage(goals);

    return Scaffold(
      body: ListView(
        children: [
          Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  CircularPercentIndicator(
                    header: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Your overall progress', style: TextStyle(
                          color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w600),),
                    ),
                    radius: 40.0,
                    lineWidth: 5.0,
                    percent: percentage,
                    center: Text("${(percentage * 100).toStringAsFixed(0)} \%",
                        style: TextStyle(color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                    progressColor: Colors.lightGreen,
                    animation: true,
                    animationDuration: 500,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Your Goal board', style: TextStyle(
                        color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w800),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .45,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(child: Text('Goal',
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600))),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(child: Text('Reward',
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600))),
                            ),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    controller: goalController,
                                    decoration: InputDecoration(
                                      hintText: 'Weight goal in KG',
                                      hintStyle: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 12,),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a goal';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: pickedDate != null ? 3 : 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2101),
                                          );
                                          setState(() {
                                            pickedDate = picked;
                                          });
                                          // Clear any error messages when a date is picked
                                          _dateError = null;
                                        },
                                        style: ElevatedButton.styleFrom(

                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                bottomRight: Radius.circular(5),),
                                            side: BorderSide(
                                              color: _dateError == null ? Colors.black54 : Colors.red, // Check if there's an error message
                                              width: 1.0,
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                          elevation:0,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 6, bottom: 6),
                                          child: pickedDate != null ? Padding(
                                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                                            child: Center(child: Icon(Icons.check, color: Colors.blue)),
                                          ) : Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              pickedDate == null &&
                                                  _dateError == null
                                                  ? Icon(Icons.date_range, color: Colors.blue,)
                                                  :
                                              SizedBox(width: 10),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                                                child: Text(pickedDate == null ? _dateError ?? 'Pick date' // Show error message or 'Select date' text
                                                      : '',
                                                  style: TextStyle(
                                                      color: pickedDate == null &&
                                                          _dateError == null ?
                                                      Colors.blue : _dateError != null ? Colors.red : Colors.blue,
                                                      fontSize: 12,
                                                      fontWeight: pickedDate == null && _dateError == null
                                                          ?
                                                      FontWeight.w500 : _dateError != null ?
                                                      FontWeight.w800 : FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFormField(
                                    controller: rewardController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your reward',
                                      hintStyle: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 12,),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a reward';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: IconButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (pickedDate == null) {
                                          setState(() {
                                            _dateError = 'Please pick a date';
                                          });
                                        } else {
                                          final newGoal = {
                                            'goal': goalController.text,
                                            'date': pickedDate?.toLocal()
                                                .toString()
                                                .split(' ')[0],
                                            'reward': rewardController.text,
                                            'achieved': false
                                          };
                                          setState(() {
                                            goals.add(newGoal);
                                            goalController.clear();
                                            rewardController.clear();
                                            pickedDate = null;
                                            _dateError = null;
                                          });
                                          DatabaseService(uid: user!.uid)
                                              .addgoal(newGoal);
                                        }
                                      }
                                    },
                                    icon: Icon(Icons.add_circle_outline, size: 30, color: Colors.black54,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        Expanded(
                          child: goals.isEmpty
                              ? Center(
                            child: Text('No goals added'),
                          )
                              : SizedBox(
                                width: MediaQuery.of(context).size.width * .9,
                                child: SingleChildScrollView(
                                  child: DataTable(
                                    columnSpacing: 0,
                                    horizontalMargin: 0,
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'Goal',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Due Date',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Reward',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Achieved',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              rows: goals
                                  .map(
                                    (goal) =>
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                            Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.of(context).size.width * .25, // set the maximum width for the cell
                                                ),
                                                child: Text(goal['goal'], maxLines: 3))),
                                        DataCell(
                                            Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.of(context).size.width * .15 // set the maximum width for the cell
                                                ),  child: Text(DateFormat('MMM d').format(DateTime.parse((goal['date']))), maxLines: 3))),
                                        DataCell(
                                            Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.of(context).size.width * .3, // set the maximum width for the cell
                                                ), child: Text(goal['reward'], maxLines: 3))),
                                        DataCell(goal['achieved'] ? Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width * .1, // set the maximum width for the cell
                                          ),
                                          child: Center(
                                            child: Icon(
                                                Icons.check_circle, color: Colors.lightGreen,),
                                          ),
                                        ) :
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width * .1, // set the maximum width for the cell
                                          ),
                                          child: Center(
                                            child: IconButton(onPressed: () async {
                                              await DatabaseService(uid: user!.uid)
                                                  .achieved(goal['index']);
                                              setState(() {
                                                goals[goal['index']]['achieved'] =
                                                true;
                                              });
                                              makealert(goal['goal']);
                                            }, icon: Icon(Icons.radio_button_unchecked)),
                                          ),
                                        ))
                                      ],
                                    ),
                              )
                                  .toList(),
                            ),
                                ),
                              ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),

    );
  }

 makealert(goal) {
    return AnimatedSnackBar(
      builder: ((context) {
        return Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            elevation: 0,
            color: Colors.black12.withOpacity(.8),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Icon(Icons.check,
                        size: 30, color: Colors.green,),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('     \u{1F389} Congrats \u{1F389}', style:  TextStyle(color: Colors.white.withOpacity(.7), fontSize: 18, fontWeight: FontWeight.w600),),
                          Text('You have achieved ${goal}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:  TextStyle(color: Colors.white70.withOpacity(.6), fontSize: 14, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ).show(context);
  }
}
