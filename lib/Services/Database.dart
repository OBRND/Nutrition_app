import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gebeta/Model/Goal.dart';
import 'package:gebeta/Model/Payment.dart';
import 'package:gebeta/Model/Recipee.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference User_info = FirebaseFirestore.instance.collection('Users');
  final CollectionReference Orders = FirebaseFirestore.instance.collection('Orders');
  final CollectionReference Chats = FirebaseFirestore.instance.collection('Chats');
  final CollectionReference Plan = FirebaseFirestore.instance.collection('mealPlans');
  final CollectionReference Goals = FirebaseFirestore.instance.collection('Goal');
  final CollectionReference Default = FirebaseFirestore.instance.collection('Basic');
  final CollectionReference recipees = FirebaseFirestore.instance.collection('recepies');
  final CollectionReference feed = FirebaseFirestore.instance.collection('Feedback');

  // Map data = {
  //   "weight_gain": [
  //     {
  //       "meal": "Breakfast",
  //       "calories": 400,
  //       "ingredients": [
  //         {"name": "Fir-fir", "calories": 250},
  //         {"name": "Yogurt", "calories": 150}
  //       ]
  //     },
  //     {
  //       "meal": "Lunch",
  //       "calories": 690,
  //       "ingredients": [
  //         {"name": "Tibs", "calories": 500},
  //         {"name": "Timatim salad", "calories": 50},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Dinner",
  //       "calories": 940,
  //       "ingredients": [
  //         {"name": "Doro kitfo", "calories": 600},
  //         {"name": "Gomen besiga", "calories": 200},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Breakfast",
  //       "calories": 400,
  //       "ingredients": [
  //         {"name": "Chechebsa", "calories": 250},
  //         {"name": "Yogurt", "calories": 150}
  //       ]
  //     },
  //     {
  //       "meal": "Lunch",
  //       "calories": 690,
  //       "ingredients": [
  //         {"name": "Kitfo", "calories": 450},
  //         {"name": "Gomen", "calories": 100},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Dinner",
  //       "calories": 700,
  //       "ingredients": [
  //         {"name": "Alicha wot", "calories": 300},
  //         {"name": "Shiro", "calories": 200},
  //         {"name": "Rice", "calories": 200}
  //       ]
  //     },
  //     {
  //       "meal": "Breakfast",
  //       "calories": 450,
  //       "ingredients": [
  //         {"name": "Chechebsa", "calories": 300},
  //         {"name": "Ful", "calories": 150}
  //       ]
  //     },
  //     {
  //       "meal": "Lunch",
  //       "calories": 840,
  //       "ingredients": [
  //         {"name": "Doro wot", "calories": 600},
  //         {"name": "Gomen", "calories": 100},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Dinner",
  //       "calories": 740,
  //       "ingredients": [
  //         {"name": "Siga tibs", "calories": 500},
  //         {"name": "Atakilt wot", "calories": 100},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     }
  //   ],
  //   "weight_maintain": [
  //     {
  //       "meal": "Breakfast",
  //       "calories": 340,
  //       "ingredients": [
  //         {"name": "Shiro besiga", "calories": 200},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Lunch",
  //       "calories": 320,
  //       "ingredients": [
  //         {"name": "Gomen", "calories": 100},
  //         {"name": "Kik alicha", "calories": 80},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Dinner",
  //       "calories": 640,
  //       "ingredients": [
  //         {"name": "Zilzil tibs", "calories": 400},
  //         {"name": "Atakilt wot", "calories": 100},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Breakfast",
  //       "calories": 340,
  //       "ingredients": [
  //         {"name": "Ful medames", "calories": 200},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Lunch",
  //       "calories": 590,
  //       "ingredients": [
  //         {"name": "Doro alicha", "calories": 350},
  //         {"name": "Atakilt wot", "calories": 100},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Dinner",
  //       "calories": 610,
  //       "ingredients": [
  //         {"name": "Yebeg wot", "calories": 400},
  //         {"name": "Tikel gomen", "calories": 70},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Breakfast",
  //       "calories": 290,
  //       "ingredients": [
  //         {"name": "Fitfit", "calories": 250},
  //         {"name": "Labneh", "calories": 40}
  //       ]
  //     },
  //     {
  //       "meal": "Lunch",
  //       "calories": 340,
  //       "ingredients": [
  //         {"name": "Yemiser wot", "calories": 150},
  //         {"name": "Timatim salad", "calories": 50},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     },
  //     {
  //       "meal": "Dinner",
  //       "calories": 690,
  //       "ingredients": [
  //         {"name": "Gored gored", "calories": 350},
  //         {"name": "Gomen besiga", "calories": 200},
  //         {"name": "Enjera", "calories": 140}
  //       ]
  //     }
  //   ],
  //   "weight_loss": [
  //     {
  //       "meal": "Breakfast",
  //       "calories": 150,
  //       "ingredients": [
  //         {"name": "Boiled eggs", "calories": 140},
  //         {"name": "Salad (mixed greens)", "calories": 10}
  //       ]
  //     },
  //     {
  //       "meal": "Lunch",
  //       "calories": 190,
  //       "ingredients": [
  //         {"name": "Buticha", "calories": 100},
  //         {"name": "Kik alicha", "calories": 80},
  //         {"name": "Salad (mixed greens)", "calories": 10}
  //       ]
  //     },
  //     {
  //       "meal": "Dinner",
  //       "calories": 260,
  //       "ingredients": [
  //         {"name": "Yekik wot", "calories": 150},
  //         {"name": "Gomen", "calories": 100},
  //         {"name": "Salad (mixed greens)", "calories": 10}
  //       ]
  //     },
  //     {
  //       "meal": "Breakfast",
  //       "calories": 160,
  //       "ingredients": [
  //         {"name": "Scrambled eggs with tomatoes and onions", "calories": 150},
  //         {"name": "Salad (mixed greens)", "calories": 10}
  //       ]
  //     },
  //     {
  //       "meal": "Lunch",
  //       "calories": 290,
  //       "ingredients": [
  //         {"name": "Mesir wot", "calories": 200},
  //         {"name": "Yekik alicha", "calories": 80},
  //         {"name": "Salad (mixed greens)", "calories": 10}
  //       ]
  //     },
  //     {
  //       "meal": "Dinner",
  //       "calories": 260,
  //       "ingredients": [
  //         {"name": "Gomen besiga", "calories": 200},
  //         {"name": "Azifa", "calories": 50},
  //         {"name": "Salad (mixed greens)", "calories": 10}
  //       ]
  //     },
  //     {
  //       "meal": "Breakfast",
  //       "calories": 280,
  //       "ingredients": [
  //         {"name": "Ambasha", "calories": 200},
  //         {"name": "Sliced avocado", "calories": 80}
  //       ]
  //     },
  //     {
  //       "meal": "Lunch",
  //       "calories": 190,
  //       "ingredients": [
  //         {"name": "Tikel gomen", "calories": 80},
  //         {"name": "Buticha", "calories": 100},
  //         {"name": "Salad (mixed greens)", "calories": 10}
  //       ]
  //     },
  //     {
  //       "meal": "Dinner",
  //       "calories": 490,
  //       "ingredients": [
  //         {"name": "Yedoro tibs", "calories": 400},
  //         {"name": "Fosolia", "calories": 80},
  //         {"name": "Salad (mixed greens)", "calories": 10}
  //       ]
  //     }
  //   ],
  // } as Map<String, dynamic>;


  // Future setBasics() async{
  //   await Default.doc('Default').set(data);
  //
  // }

  Future getdata(String subscription) async{
    DocumentSnapshot snap = await Default.doc('Default').get();
    List data = snap[subscription == 'weight gain'? "weight_gain": subscription == 'weight loss'? "weight_loss": "weight_maintain"];
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

  Future addgoal(Map goal) async{
    DocumentSnapshot snap = await Goals.doc(uid).get();
    List newgoals = snap['goals'];
    newgoals.add(goal);
    print(goal);
    await Goals.doc(uid).set({
      'goals' : newgoals
    });
  }

  Future getgoals() async{
    DocumentSnapshot snap = await Goals.doc(uid).get();
    if(snap['goals'] == null){
      return [];
    }
    else {
      List<Map<String, dynamic>> goals = [];
      for(int i = 0; i < snap['goals'].length; i++){
        goals.add({
          'goal': snap['goals'][i]['goal'],
          'date': snap['goals'][i]['date'],
          'reward': snap['goals'][i]['reward'],
          'achieved': snap['goals'][i]['achieved'],
          'index': i
        });
      }
      print(goals);
      return goals;
    }
  }

  Future achieved(int index) async {
    DocumentSnapshot snap = await Goals.doc(uid).get();
    List allgoals = snap['goals'];
    allgoals[index]['achieved'] = true;
    await Goals.doc(uid).update({'goals': allgoals})
        .then((value) => print('updated successfully'))
        .catchError((onError) => print(onError));
  }

  Future getchat(String chatid) async{
    List chatlist;
    DocumentSnapshot chat = await Chats.doc(chatid).get();
    // if(chat.exists){
    //   print('No chat exists');
    // }
    // print('|||||||||${chat['chats']}');
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
  // Future updateunread(String chatid) async{
  //   DocumentSnapshot doc = await Chats.doc(chatid).get();
  //   int unread = doc['unread'];
  //   await Chats.doc(chatid).update({
  //     'unread': unread + 1 ,
  //     'date' : DateTime.now()
  //   });
  // }

  Future getuserInfo() async{
    // FirebaseFirestore _instance= FirebaseFirestore.instance;

    DocumentSnapshot User_Profile = await User_info
        .doc('$uid').get();
    var first = User_Profile['First_name'];
    var last = User_Profile['Last_name'];
    var phone = User_Profile['Phone_number'];
    var plan = User_Profile['subscription'];

    print(first);
    print(last);
    print(phone);
    return [first,last,phone, plan];
  }

  Future getPlan() async{
    QuerySnapshot snap = await Plan.where('orderId', isEqualTo: uid).get();
    print(snap.docs[0]['weekPlans']);
    List weekplan = snap.docs[0]['weekPlans'];
    return weekplan;
  }

  Future feedback(String message) async{
    List user = await getuserInfo();
    await feed.doc(uid).set({
      'Account_name': user[0] + " " + user[1],
      'Message': message,
      'Date': DateTime.now()
    });
  }

  Future getlastdate() async{
    QuerySnapshot snap = await Plan.where('orderId', isEqualTo: uid).get();
    String endDate = snap.docs[0]['endDate'];
    return endDate;
  }

  Future getrecipee(recpeeId) async{
    DocumentSnapshot snap = await recipees.doc(recpeeId).get();
    print(snap['name']);
    print(snap['cookingTime']);
    print(snap['imageUrl']);
    print(snap['ingredients']);
    Recipee recipee = Recipee(cookingTime: snap['cookingTime'], imageURL: snap['imageUrl'],
        name: snap['name'], ingredients: snap['ingredients']);
    return recipee;
  }

  Future updateUserData(String First_name, String Last_name, String Phone_number, gender, age, weight, height, String selectedPlan) async {
    await Goals.doc(uid).set({
      'goals': []
    });
    List info =  [0,0,0,0];
    if(age != 0){
    info = await getuserInfo();
    }
    return await User_info.doc(uid).set({
      'First_name': First_name,
      'Last_name': Last_name,
      'Phone_number': Phone_number,
      'subscription': selectedPlan == "0" ? "weight loss": selectedPlan == "1" ? "weight maintain" :selectedPlan == "2" ? "weight gain": info[3],
      'gender': gender  == 0 ? 'Male' : gender,
      'height': height == 0 ? 0: height,
      'age': age == 0 ? 0: age,
      'weight': weight == 0 ? 0: weight,
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
      'uid': uid,
      'Completed': false
    });
  }

//get user stream
  Stream<QuerySnapshot> get info {
    return User_info.snapshots();
  }
}