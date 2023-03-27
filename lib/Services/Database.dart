import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference User_info = FirebaseFirestore.instance.collection('Users');

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

  Future updateUserData(String First_name, String Last_name,
      String Phone_number) async {
    return await User_info.doc(uid).set({
      'First_name': First_name,
      'Last_name': Last_name,
      'Phone_number': Phone_number
    });
  }

//get user stream
  Stream<QuerySnapshot> get info {
    return User_info.snapshots();
  }
}