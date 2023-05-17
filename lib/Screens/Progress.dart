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


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);

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
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .45,
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
                                  flex: 2,
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
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () async {
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
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              5),
                                          border: Border.all(
                                            color: _dateError == null ? Colors.black : Colors.red, // Check if there's an error message
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              pickedDate == null &&
                                                  _dateError == null
                                                  ? Icon(Icons.date_range)
                                                  : SizedBox(),
                                              SizedBox(width: 10),
                                              Text(pickedDate == null ? _dateError ?? 'Pick date' // Show error message or 'Select date' text
                                                    : '${pickedDate!.toLocal().toString().split(' ')[0]}',
                                                style: TextStyle(
                                                    color: pickedDate == null &&
                                                        _dateError == null ?
                                                    Colors.black : _dateError !=
                                                        null
                                                        ? Colors.red : Colors.blue,
                                                    fontSize: 12,
                                                    fontWeight: pickedDate ==
                                                        null &&
                                                        _dateError == null
                                                        ?
                                                    FontWeight.w500
                                                        : _dateError != null ?
                                                    FontWeight.w800 : FontWeight
                                                        .w300),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                                Expanded(
                                  flex: 3,
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
                                  flex: 1,
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
                                    icon: Icon(Icons.add),
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
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: DataTable(
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
                                                  maxWidth: MediaQuery.of(context).size.width * .08, // set the maximum width for the cell
                                                ),
                                                child: Text(goal['goal'], maxLines: 3))),
                                        DataCell(
                                            Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.of(context).size.width * .14 // set the maximum width for the cell
                                                ),  child: Text(DateFormat('MMM d').format(DateTime.parse((goal['date']))), maxLines: 3))),
                                        DataCell(
                                            Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.of(context).size.width * .1, // set the maximum width for the cell
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
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  behavior: SnackBarBehavior.floating,
                                                  content: Builder(
                                                    builder: (BuildContext context) {
                                                      final snackBarHeight = Scaffold.of(context).appBarMaxHeight! + kToolbarHeight;
                                                      return Padding(
                                                        padding: EdgeInsets.only(top: snackBarHeight),
                                                        child: Align(
                                                          alignment: Alignment.topRight,
                                                          child: AnimatedToast(message: 'Congrats on achieving ${goal['goal']}!'),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  duration: Duration(seconds: 2),
                                                ),
                                              );



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
}
