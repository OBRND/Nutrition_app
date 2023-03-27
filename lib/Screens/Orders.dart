import 'package:flutter/material.dart';
import 'package:gebeta/Screens/Place_order/placeOrderPages.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children:[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text('Get a meal plan by our professional consultants with just a tap.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  selectFood()));
            }, child: Text('Place order'),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20) ),
                backgroundColor: Colors.brown),),
            Text('past orders'),
            Text('No orders yet')

    ])
    );
  }
}
