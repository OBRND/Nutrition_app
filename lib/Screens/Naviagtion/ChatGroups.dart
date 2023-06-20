import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  // const Support({Key? key}) : super(key: key);
  final String chatID;
  const Chat({required this.chatID});

  @override
  State<Chat> createState() => _ChatState(chatID: chatID);
}

class _ChatState extends State<Chat> {
  String chatID;
  _ChatState({required this.chatID});
  List messages = [ ];
  CollectionReference snapshot = FirebaseFirestore.instance.collection('Chats');
  var image = File('1.jpg');

  Stream messagesStream() {
    return snapshot.doc('$chatID').snapshots();
    // return chats;
  }

  Future getallmessages() async{
    final user = Provider.of<UserFB?>(context);
    final DatabaseService db = DatabaseService(uid: user!.uid);
    List result = await db.getchat(chatID);
    messages = result;
    print(result);
    // setState(() => messages = result);
    return messages;
  }
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.lightGreen,
        title: Text('Chat Room', style: TextStyle(color: Colors.black54),),),
      body: Stack(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 56),
              child: Container(
                height: MediaQuery.of(context).size.height * .9,
                child: FutureBuilder(
                    future: getallmessages(),
                    builder: (BuildContext context,AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black38,
                              ));
                        default:
                          if(snapshot.data == null){
                            DatabaseService(uid: user!.uid).createChat();
                          }
                          return StreamBuilder(
                            stream: messagesStream(),
                            builder: (BuildContext context, AsyncSnapshot snap) {
                              if(!messages.contains(snap.data['chats'].last)){
                                messages.add(snap.data['chats'].last);
                              }
                              print('stream rebuilt');
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              // messages.add(ChatMessage(messageContent: '${snap.data['chatValues']['4y9r3uWdmZgahwguu5cjjl3fodk2 ${messages.length}']}',
                              //     messageType: 'sender', type: 'text'));
                              // print(snap.data['chatValues'][0]);
                              return Align(
                                alignment: Alignment.topCenter,
                                child: ListView.builder(
                                  // controller: _sc,
                                  reverse: true,
                                  dragStartBehavior: DragStartBehavior.down,
                                  itemCount: snapshot.data.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final reversedIndex = snapshot.data.length - 1 - index;
                                    // WidgetsBinding.instance.addPostFrameCallback((_) => {_sc.jumpTo(_sc.position.maxScrollExtent)});
                                    // messages[reversedIndex].type == 'image' ? print('an image'): print(' a text');
                                    return Container(
                                      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                                      child: Align(
                                        alignment: (snapshot.data[reversedIndex].toString().startsWith('${user?.uid.substring(0,5)}') ? Alignment.topRight : Alignment.topLeft),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: (snapshot.data[reversedIndex].toString().startsWith('${user?.uid.substring(0,5)}') ? Colors.grey.shade200 : Colors.blue[200]),
                                          ),
                                          padding: EdgeInsets.all(16),
                                          child: snapshot.data[reversedIndex].toString().startsWith('image') ?
                                          Container(
                                            child: Image.network(
                                              '${snapshot.data[reversedIndex]}',
                                              errorBuilder:  (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.black12,
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    'Whoops!, check your connection and try again',
                                                    style: TextStyle(fontSize: 25),
                                                  ),
                                                );
                                              },
                                            ),
                                          ) : Text(snapshot.data[reversedIndex].toString().substring(5),
                                            style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            });
                      }
                    }
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: StreamBuilder(
                  stream: messagesStream(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return Container(
                      height: 52,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.lightGreen,
                      child: Column(
                        children: [
                          SizedBox(
                              height: 3
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(onPressed: () async{
                                SnackBar snackBar = SnackBar(
                                  backgroundColor: Colors.transparent,
                                  content: Card(
                                      color: Colors.redAccent,
                                      child: Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.dangerous_rounded),
                                            Text(' please pick a file!', style: TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.w600
                                            ),),
                                          ],
                                        ),
                                      )),
                                );

                              }, child: Icon(Icons.photo_library_rounded, size: 25),
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black54),
                                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent,
                                    )),),
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width *.6,
                                child: TextFormField(
                                  validator: (val) => val!.isEmpty ? 'Enter a message' : null,
                                  style: TextStyle(fontSize: 20),
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    // fillColor: Color(0xffd4d4d5),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffd4d4d5),width: 0),
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    ),
                                  ),
                                  controller: myController,
                                ),
                              ),
                              TextButton(onPressed: () async{
                                // var result = await storage.getdata(tradesID);
                                // print(result);
                                print('${myController.text}');

                                await DatabaseService(uid: user!.uid).updatechat(myController.text, chatID);
                                await DatabaseService(uid: user!.uid).updateunread(chatID);
                                // await db.getmessages();
                                setState(() => myController.text = ''
                                );
                              }, child: Icon(Icons.send_rounded, size: 28,),
                                style: ButtonStyle(
                                  // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  // RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)),
                                    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black54),
                                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Card(
              margin: EdgeInsets.zero,
              color: Colors.black54.withOpacity(.6),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('This chat is for people to share their jorney and experiences to maintain their weight',
                  style:  TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w300),),
              ),
            ),
          ]
      ),
    );
  }
}
