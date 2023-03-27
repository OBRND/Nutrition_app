import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}

double percentage = 0.75;
int intake = 1900;

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(8),
                  child: Text('Your overall progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                ),
                radius: 80.0,
                lineWidth: 10.0,
                percent: percentage,
                center: Text("${(percentage * 100).toStringAsFixed(0)} \%",
                    style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.w700)),
                progressColor: Colors.amber,
                animation: true,
                animationDuration: 500,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Text('Average calorie intakes / day', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  Text(intake.toString(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.green),)
                ],
              ),

            ],
          )),
        ],
      ),

    );
  }
}
