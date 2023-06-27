import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/Ingridients.dart';
import 'package:gebeta/Screens/Place_order/placeOrderPages.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:gebeta/Services/user_provider.dart';
import 'package:gebeta/main.dart';
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome home',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Remember, the key to weight management is to maintain a healthy balance'
                        ' of calories and nutrients.\n\n Consult with or nutritionists to '
                        'create a meal plan that meets your specific needs and goals.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlaceOrder()));
                  },
                  child: Text(
                    'Place order',
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    primary: Colors.brown,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                child: Text(
                  'Recommended dishes that you must try!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff5a7046),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          // Add the defaultmeals method to display recommended dishes with images
          defaultmeals(user!.uid),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //       //   onPressed: (){
      //       //     DatabaseService(uid: user!.uid).getdata();
      //       //   },
      //       // ),
    );

  }

  Widget defaultmeals(String uid) {
    final userProvider = Provider.of<UserProvider>(context);
    final subscription = userProvider.subscription;
    return FutureBuilder(
        future: DatabaseService(uid: uid).getdata(subscription!),
    builder: (context,AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return Center(
          child: Text('Loading contents...',
            style: TextStyle(fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w300),),
        );
    // case (ConnectionState.done) :
      default: return Column(
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .15,
                        child: getimages(snapshot.data[0]),
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .15,
                        child: getimages(snapshot.data[1]),
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .15,
                        child: getimages(snapshot.data[2])
                    )
                  ],
                )
            ),
          ],
        );
    }
        }
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
                Ingredient(name: data[index]["ingredients"][i]['name'], calories: (data[index]["ingredients"][i]['calories'].toString() +' cal'), amount: 0, measurement: ''),
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
