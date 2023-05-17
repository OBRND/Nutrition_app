import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/Place_order/placeOrderPages.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Orders',),
      ),
      body: Column(
          children:[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text('Get a meal plan by our professional consultants with just a tap.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  PlaceOrder()));
            }, child: Text('Place order'),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20) ),
                backgroundColor: Colors.brown),),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('past orders', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),)),
            ),
            FutureBuilder(
              future: DatabaseService(uid: user!.uid).getOrder(),
                builder: (context,AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Checking there are previous orders',
                        style: TextStyle(fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),);
                  // case (ConnectionState.done) :
                    default:
                      if(snapshot.data == null){
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('No orders yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black54),),
                      );
                    }else
                      return ExpandablePanel(
                          header: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
                            child: Text('Contract : ${snapshot.data[0]}',style: TextStyle(color:Color(0xff2F2929), fontSize: 19, fontWeight: FontWeight.w300),),
                          ),
                          collapsed:  Padding(
                            padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
                            child: Text('Plan: ${snapshot.data[1]}',style: TextStyle(color:Color(0xff2F2929), fontSize: 19, fontWeight: FontWeight.w300),),
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Paid with Chappa - ${snapshot.data[2]} br.',
                                  style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w300),),
                                Text('Transaction reference: ${snapshot.data[2]} ${snapshot.data[3]}',
                                  style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w300),),
                              ],
                            ),
                          )
                      );
                  }
                }
                ),
    ])
    );
  }
}
