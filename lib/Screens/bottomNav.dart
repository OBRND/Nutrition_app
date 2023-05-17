import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gebeta/Screens/Home.dart';
import 'package:gebeta/Screens/Naviagtion/ChatGroups.dart';
import 'package:gebeta/Screens/Orders.dart';
import 'package:gebeta/Screens/Profile.dart';
import 'package:gebeta/Screens/Progress.dart';
import 'package:gebeta/Services/Auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'Custom_Plan.dart';

class BottomTab extends StatefulWidget {
  // const BottomTab({Key? key}) : super(key: key);
  final int index;
  BottomTab({required this.index});

  @override
  State<BottomTab> createState() => _BottomTabState(selectedIndex:index);
}

class _BottomTabState extends State<BottomTab> {
  int selectedIndex;
  _BottomTabState({required this.selectedIndex});
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Progress(),
    Home(),
    Custom_Plan()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  String select = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: Color(0x245a7046),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Profile()));
                    },
                    child: Image.asset(select == 'Male'
                        ? 'Assets/img.png'
                        : 'Assets/img_1.png')),

                // child: IconButton(onPressed: (){
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder :(context) => Profile()));
                // }, icon: Icon(Icons.person, color: Colors.black54)),
              ),
            ),
            toolbarHeight: 70,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gebeta', style: TextStyle(
                            color: Color(0xff5a7046), fontSize: 25)),
                        Text('           Nutrition', style: TextStyle(
                            color: Color(0xffb9a674), fontSize: 16))
                      ]),
                ],
              ),
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.black54,
            ),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (String result) {

                },
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'chat room',
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Chat(chatID: 'Public',)));
                      },
                      child: Text('Chat room',
                        style: TextStyle(color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'orders',
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Orders(),));
                      },
                      child: Text('Orders',
                        style: TextStyle(color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),),
                    ),
                  ),
                  PopupMenuItem<String>(
                      value: 'Log_out',
                      child: TextButton(
                        onPressed: () {
                          Auth_service().sign_out();
                        },
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.doorOpen, size: 18,
                              color: Colors.red,),
                            Text('  Log out',
                              style: TextStyle(color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      )
                  ),
                ],)
            ]),
        drawer: Drawer(

          child: Container(
            width: 100,
            height: 200, // set the width of the drawer here
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Gebeta Nutrition'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // do something
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // do something
                  },
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            rippleColor: Colors.lightGreen!,
            hoverColor: Colors.orange!,
            gap: 12,
            activeColor: Colors.black,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            tabActiveBorder: Border.all(color: Colors.green, width: 1),
            color: Color(0xffdae0e0),
            textStyle: TextStyle(fontSize: 22),
            tabs: const [
              GButton(
                icon: Icons.person,
                text: 'Progress',
                iconSize: 25,
                iconColor: Colors.black54,
              ),
              GButton(
                icon: Icons.home,
                text: 'Home',
                iconSize: 25,
                iconColor: Colors.black54,
              ),
              GButton(
                iconColor: Colors.black54,
                icon: Icons.list,
                text: 'Plan',
                iconSize: 25,
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        )
    );
  }
}

