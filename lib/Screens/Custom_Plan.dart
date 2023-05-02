import 'package:flutter/material.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/Ingridients.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:provider/provider.dart';

class Custom_Plan extends StatefulWidget {
  const Custom_Plan({Key? key}) : super(key: key);

  @override
  State<Custom_Plan> createState() => _Custom_PlanState();
}

class _Custom_PlanState extends State<Custom_Plan> {
  int _selectedIndex = DateTime.now().weekday - 1;
  int _selectedDate = DateTime.now().day;
  final List<String> _daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    List<DateTime> weekDays = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    while(weekDays[0].month != now.month) {
      startOfWeek = startOfWeek.add(Duration(days: 7));
      weekDays = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
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
            Center(
              child: Container(
                height: 62,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _daysOfWeek.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: 50,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        padding: EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                          color: index == _selectedIndex ? Colors.lightGreen : Colors
                              .grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Column(
                              children:[
                                Text(weekDays[index].day.toString(),style: TextStyle(fontSize: 20, fontWeight: index == _selectedIndex ? FontWeight.bold : FontWeight.w300,
                                  color: index == _selectedIndex ? Colors.white : Colors.black,
                                ),),
                                // Text( index < _selectedIndex && _selectedDate + index < 31 && _selectedDate + index > 0 ? (_selectedDate - _selectedIndex).toString():
                                // index > _selectedIndex && _selectedDate + index < 31 ? (_selectedDate + index).toString() :
                                // _selectedDate + index == 31 ? '0' : _selectedDate.toString() ),
                                Text(
                                  _daysOfWeek[index],
                                  style: TextStyle(fontSize: 12, fontWeight: index == _selectedIndex ? FontWeight.bold : FontWeight.w300,
                                    color: index == _selectedIndex ? Colors.white : Colors.black,
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
                              builder: (context) =>  IngredientsPage(
                                foodName: 'Enkulal',
                                imageURL: 'https://img.jamieoliver.com/jamieoliver/recipe-database/oldImages/large/576_1_1438868377.jpg?tr=w-800,h-1066',
                                ingredients: [
                                  Ingredient(name: 'eggs', calories: 20, amount: '2 large'),
                                  Ingredient(name: 'zeyet', calories: 50, amount: '2 tea spoons'),
                                  Ingredient(name: 'shenkurt', calories: 100, amount: '2 medium'),
                                  Ingredient(name: 'timatim', calories: 200, amount: '3 medium'),
                                ], totalCalories: 0,
                              )));
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
