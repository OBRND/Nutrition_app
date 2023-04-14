import 'package:flutter/material.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/Ingridients.dart';
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
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>  IngredientsPage()));
                        },
                        child: Column(
                            children:[
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(height: 100,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                              child: Image.asset('Assets/img_3.png',fit: BoxFit.fitWidth,))),
                                      Container(
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Fried Eggs', style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500),),
                                            Row(
                                              children: [
                                                Text('Cooking time - ',
                                                  style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w700, fontSize: 14),),
                                                Text('10 min', style: TextStyle(color: Colors.black54, fontSize: 12),),
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
                    child: Text('Lunch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.brown),),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          children:[
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(height: 100, width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: ClipRRect(
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                        child: Image.asset('Assets/img_2.png',fit: BoxFit.fitWidth,))),
                                    Container(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Gomen wet', style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500),),
                                          Row(
                                            children: [
                                              Text('Cooking time - ',
                                                style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w700, fontSize: 14),),
                                              Text('25 min', style: TextStyle(color: Colors.black54, fontSize: 12),),
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
                          ])

                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Dinner', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.brown),),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          children:[
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(height: 100, width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                            child: Image.asset('Assets/img_4.png',fit: BoxFit.fitWidth,))),
                                    Container(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Sega wet', style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500),),
                                          Row(
                                            children: [
                                              Text('Cooking time - ',
                                                style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w700, fontSize: 14),),
                                              Text('40 min', style: TextStyle(color: Colors.black54, fontSize: 12),),
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
                          ])

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
