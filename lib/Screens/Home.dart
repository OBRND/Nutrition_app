import 'package:flutter/material.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Services/Auth.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List selected = [false, false,false,false,false,false,false];
String name = '';

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  FutureBuilder(
                      future: DatabaseService(uid:user!.uid).getuserInfo(),
                      builder: (context,AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return   Text('Hello',
                              style: TextStyle(fontSize: 20,color: Colors.black54, fontWeight: FontWeight.w500),);
                        // case (ConnectionState.done) :
                          default:  return Text('Hello, ${ snapshot.data[0]}',
                            style: TextStyle(fontSize: 20,color: Colors.black54, fontWeight: FontWeight.w500),);

                      }
                      }),
                    Text('check out what\'s for today', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),),
                  ],
                ),
              ),
            ),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: (){}, icon: Icon(Icons.arrow_back),
                  color: Colors.blueAccent,
                  ),
                  Center(child: Text(DateFormat.EEEE().format(DateTime.now()).toString(), style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 18),)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward),
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Breakfast', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.brown),),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    elevation: 2,
                    color: Colors.white70,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            children:[
                              SizedBox(
                                height: 10,
                              ),
                              Text('Your meals'),
                              Text('Your meals'),
                              Text('Your meals'),
                              Text('Your meals'),
                              SizedBox(
                                height: 10,
                              ),
                            ])

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Lunch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.brown),),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    elevation: 2,
                    color: Colors.white70,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            children:[
                              SizedBox(
                                height: 10,
                              ),
                              Text('Your meals'),
                              Text('Your meals'),
                              Text('Your meals'),
                              Text('Your meals'),
                              SizedBox(
                                height: 10,
                              ),
                            ])

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Dinner', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.brown),),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    elevation: 2,
                    color: Colors.white70,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            children:[
                              SizedBox(
                                height: 10,
                              ),
                              Text('Your meals'),
                              Text('Your meals'),
                              Text('Your meals'),
                              Text('Your meals'),
                              SizedBox(
                                height: 10,
                              ),
                            ])

                    ),
                  ),

                ],
              ),
            )
          ],
        ),

       // color: Colors.orange,
      ),

    );
  }

}
