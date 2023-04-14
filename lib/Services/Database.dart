import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gebeta/Model/Payment.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference User_info = FirebaseFirestore.instance.collection('Users');
  final CollectionReference Orders = FirebaseFirestore.instance.collection('Orders');
  final CollectionReference Chats = FirebaseFirestore.instance.collection('Chats');

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