import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gebeta/Model/Payment.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference User_info = FirebaseFirestore.instance.collection('Users');
  final CollectionReference Orders = FirebaseFirestore.instance.collection('Orders');
  final CollectionReference Chats = FirebaseFirestore.instance.collection('Chats');
  final CollectionReference Plan = FirebaseFirestore.instance.collection('Meal plan');
  final CollectionReference Default = FirebaseFirestore.instance.collection('Basic');

  Map data = {
    "weight_gain": [
      {
        "meal": "Breakfast",
        "calories": 400,
        "ingredients": [
          {"name": "Fir-fir", "calories": 250},
          {"name": "Yogurt", "calories": 150}
        ]
      },
      {
        "meal": "Lunch",
        "calories": 690,
        "ingredients": [
          {"name": "Tibs", "calories": 500},
          {"name": "Timatim salad", "calories": 50},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Dinner",
        "calories": 940,
        "ingredients": [
          {"name": "Doro kitfo", "calories": 600},
          {"name": "Gomen besiga", "calories": 200},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Breakfast",
        "calories": 400,
        "ingredients": [
          {"name": "Chechebsa", "calories": 250},
          {"name": "Yogurt", "calories": 150}
        ]
      },
      {
        "meal": "Lunch",
        "calories": 690,
        "ingredients": [
          {"name": "Kitfo", "calories": 450},
          {"name": "Gomen", "calories": 100},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Dinner",
        "calories": 700,
        "ingredients": [
          {"name": "Alicha wot", "calories": 300},
          {"name": "Shiro", "calories": 200},
          {"name": "Rice", "calories": 200}
        ]
      },
      {
        "meal": "Breakfast",
        "calories": 450,
        "ingredients": [
          {"name": "Chechebsa", "calories": 300},
          {"name": "Ful", "calories": 150}
        ]
      },
      {
        "meal": "Lunch",
        "calories": 840,
        "ingredients": [
          {"name": "Doro wot", "calories": 600},
          {"name": "Gomen", "calories": 100},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Dinner",
        "calories": 740,
        "ingredients": [
          {"name": "Siga tibs", "calories": 500},
          {"name": "Atakilt wot", "calories": 100},
          {"name": "Enjera", "calories": 140}
        ]
      }
    ],
    "weight_maintain": [
      {
        "meal": "Breakfast",
        "calories": 340,
        "ingredients": [
          {"name": "Shiro besiga", "calories": 200},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Lunch",
        "calories": 320,
        "ingredients": [
          {"name": "Gomen", "calories": 100},
          {"name": "Kik alicha", "calories": 80},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Dinner",
        "calories": 640,
        "ingredients": [
          {"name": "Zilzil tibs", "calories": 400},
          {"name": "Atakilt wot", "calories": 100},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Breakfast",
        "calories": 340,
        "ingredients": [
          {"name": "Ful medames", "calories": 200},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Lunch",
        "calories": 590,
        "ingredients": [
          {"name": "Doro alicha", "calories": 350},
          {"name": "Atakilt wot", "calories": 100},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Dinner",
        "calories": 610,
        "ingredients": [
          {"name": "Yebeg wot", "calories": 400},
          {"name": "Tikel gomen", "calories": 70},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Breakfast",
        "calories": 290,
        "ingredients": [
          {"name": "Fitfit", "calories": 250},
          {"name": "Labneh", "calories": 40}
        ]
      },
      {
        "meal": "Lunch",
        "calories": 340,
        "ingredients": [
          {"name": "Yemiser wot", "calories": 150},
          {"name": "Timatim salad", "calories": 50},
          {"name": "Enjera", "calories": 140}
        ]
      },
      {
        "meal": "Dinner",
        "calories": 690,
        "ingredients": [
          {"name": "Gored gored", "calories": 350},
          {"name": "Gomen besiga", "calories": 200},
          {"name": "Enjera", "calories": 140}
        ]
      }
    ],
    "weight_loss": [
      {
        "meal": "Breakfast",
        "calories": 150,
        "ingredients": [
          {"name": "Boiled eggs", "calories": 140},
          {"name": "Salad (mixed greens)", "calories": 10}
        ]
      },
      {
        "meal": "Lunch",
        "calories": 190,
        "ingredients": [
          {"name": "Buticha", "calories": 100},
          {"name": "Kik alicha", "calories": 80},
          {"name": "Salad (mixed greens)", "calories": 10}
        ]
      },
      {
        "meal": "Dinner",
        "calories": 260,
        "ingredients": [
          {"name": "Yekik wot", "calories": 150},
          {"name": "Gomen", "calories": 100},
          {"name": "Salad (mixed greens)", "calories": 10}
        ]
      },
      {
        "meal": "Breakfast",
        "calories": 160,
        "ingredients": [
          {"name": "Scrambled eggs with tomatoes and onions", "calories": 150},
          {"name": "Salad (mixed greens)", "calories": 10}
        ]
      },
      {
        "meal": "Lunch",
        "calories": 290,
        "ingredients": [
          {"name": "Mesir wot", "calories": 200},
          {"name": "Yekik alicha", "calories": 80},
          {"name": "Salad (mixed greens)", "calories": 10}
        ]
      },
      {
        "meal": "Dinner",
        "calories": 260,
        "ingredients": [
          {"name": "Gomen besiga", "calories": 200},
          {"name": "Azifa", "calories": 50},
          {"name": "Salad (mixed greens)", "calories": 10}
        ]
      },
      {
        "meal": "Breakfast",
        "calories": 280,
        "ingredients": [
          {"name": "Ambasha", "calories": 200},
          {"name": "Sliced avocado", "calories": 80}
        ]
      },
      {
        "meal": "Lunch",
        "calories": 190,
        "ingredients": [
          {"name": "Tikel gomen", "calories": 80},
          {"name": "Buticha", "calories": 100},
          {"name": "Salad (mixed greens)", "calories": 10}
        ]
      },
      {
        "meal": "Dinner",
        "calories": 490,
        "ingredients": [
          {"name": "Yedoro tibs", "calories": 400},
          {"name": "Fosolia", "calories": 80},
          {"name": "Salad (mixed greens)", "calories": 10}
        ]
      }
    ],
  } as Map<String, dynamic>;


  Future setBasics() async{
    await Default.doc('Default').set(data);

  }

  Future getdata() async{
    DocumentSnapshot snap = await Default.doc('Default').get();
    List data = snap['weight_gain'];
    List breakfast = [];
    List lunch = [];
    List dinner = [];
    print(data);


    for(int i = 0; i < data.length; i++){
      if(data[i]['meal'] == 'Breakfast'){
        breakfast.add(data[i]);
      }
      else if(data[i]['meal'] == 'Lunch'){
        lunch.add(data[i]);
      }
      else{
        dinner.add(data[i]);
      }
    }
    return [breakfast,lunch, dinner];
  }

  Future getchat(String chatid) async{
    List chatlist;
    DocumentSnapshot chat = await Chats.doc(chatid).get();
    // if(chat.exists){
    //   print('No chat exists');
    // }
    print('|||||||||${chat['chats']}');
    chatlist =  chat['chats'];
    return chatlist;
  }
  Future createChat() async{
    await Chats.doc('Public').set({
      'chatID': 'Public',
      'chats': ['r hello, this is a public chat'],
      'date': DateTime.now(),
      'unread': 1,
    });
  }

  Future updatechat(String message, String chatid) async{
    List chat = await getchat(chatid);
    chat.add('${uid.substring(0,5)} $message');
    return await Chats.doc(chatid).update({
      'chats': chat
    });

  }
  Future updateunread(String chatid) async{
    DocumentSnapshot doc = await Chats.doc(chatid).get();
    int unread = doc['unread'];
    await Chats.doc(chatid).update({
      'unread': unread + 1 ,
      'date' : DateTime.now()
    });
  }

  Future getuserInfo() async{
    // FirebaseFirestore _instance= FirebaseFirestore.instance;

    DocumentSnapshot User_Profile = await User_info
        .doc('$uid').get();
    var first = User_Profile['First_name'];
    var last = User_Profile['Last_name'];
    var phone = User_Profile['Phone_number'];

    print(first);
    print(last);
    print(phone);
    return [first,last,phone];
  }

  Future getPlan() async{
    DocumentSnapshot snap = await Plan.doc().get();
  }

  Future updateUserData(String First_name, String Last_name, String Phone_number) async {
    return await User_info.doc(uid).set({
      'First_name': First_name,
      'Last_name': Last_name,
      'Phone_number': Phone_number
    });
  }

  Future getOrder() async{
    QuerySnapshot snap = await Orders.where('uid', isEqualTo: uid).get();
    print(snap.docs[0].data());
    String contract = snap.docs[0]['contract'];
    String plan = snap.docs[0]['plan'];
    int payment = snap.docs[0]['payment_details']['amount'];
    String txRef = snap.docs[0]['payment_details']['txRef'];
   return [contract, plan, payment, txRef];
  }

  Future makeOrder(String plan, List foods, String contract, Payment payment) async{
    Map details = {
    'paymentwith' : payment.paymentwith,
    'status' : payment.status,
    'amount' : payment.amount,
    'date' : payment.date,
    'email' : payment.email,
    'fullName' : payment.fullName,
    'txRef' : payment.txRef
    };
    await Orders.doc(uid).set({
      'plan': plan,
      'foods': foods,
      'contract': contract,
      'date': DateTime.now(),
      'payment_details': details,
      'uid': uid
    });
  }

//get user stream
  Stream<QuerySnapshot> get info {
    return User_info.snapshots();
  }
}