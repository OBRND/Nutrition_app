import 'package:flutter/material.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/Ingridients.dart';
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
  Color primaryColor = Colors.white;
  Color complementColor = Colors.black;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);

    return Scaffold(
      body: ListView(
        children: [
          Text('Welcome home'),
          defaultmeals(user!.uid)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          DatabaseService(uid: user!.uid).getdata();
        },
      ),
    );

  }

  Widget defaultmeals(String uid) {
    return Column(
      children: [
        Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Breakfast',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .15,
                  child:
                  FutureBuilder(
                    future: DatabaseService(uid: uid).getdata(),
                      builder: (context,AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Text('Checking there are previous orders',
                              style: TextStyle(fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),);
                        // case (ConnectionState.done) :
                          default: return getimages(snapshot.data[0]);
                        }
                      }
                  )
                )
              ],
            )
        ),
        Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Lunch', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .15,
                    child:
                    FutureBuilder(
                        future: DatabaseService(uid: uid).getdata(),
                        builder: (context,AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Text('Checking there are previous orders',
                                style: TextStyle(fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),);
                          // case (ConnectionState.done) :
                            default: return getimages(snapshot.data[1]);
                          }
                        }
                    )
                )
              ],
            )
        ),
        Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Dinner', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .15,
                    child:
                    FutureBuilder(
                        future: DatabaseService(uid: uid).getdata(),
                        builder: (context,AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Text('Checking there are previous orders',
                                style: TextStyle(fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),);
                          // case (ConnectionState.done) :
                            default: return getimages(snapshot.data[2]);
                          }
                        }
                    )
                )
              ],
            )
        ),
      ],
    );
  }

  Widget getimages(List data) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      separatorBuilder: (context, index) {
        return const SizedBox(width: 10);
      },
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            List<Ingredient> ingred = [];
            for(int i = 0; i <data[index]["ingredients"].length; i++ ){
              ingred.add(
                Ingredient(name: data[index]["ingredients"][i]['name'], calories: double.parse(data[index]["ingredients"][i]['calories'].toString()), amount: '1'),
              );
            }

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  IngredientsPage(
                  foodName: '${data[index]["ingredients"][0]['name']} and ${data[index]["ingredients"][1]['name']}',
                  imageURL: data[index]['link'],
                  ingredients: ingred,
                  totalCalories: double.parse(data[index]["calories"].toString()),
                )));
          },
          child: Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width * .4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: NetworkImage(data[index]['link']),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.4),
                    primaryColor.withOpacity(0.2),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index]["ingredients"][0]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Text('and', style: TextStyle(color: Colors.white),),
                    Text(
                      data[index]["ingredients"][1]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
