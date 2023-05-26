import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gebeta/Model/Payment.dart';
import 'package:gebeta/Model/User.dart';
import 'package:gebeta/Screens/bottomNav.dart';
import 'package:gebeta/Services/Database.dart';
import 'package:http/http.dart' as http;

import 'package:chapasdk/chapa_payment%20initializer.dart';
import 'package:flutter/material.dart';
import 'package:gebeta/Model/Decorations.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}
List<int> _selectedItems = [];
class Plate {
  final int id;
  final String name;

  Plate({
    required this.id,
    required this.name,
  });
}
 List<Plate> _food = [
Plate(id: 1, name: "ምስር"),
Plate(id: 2, name: "ድንች"),
Plate(id: 3, name: "ስጋ"),
Plate(id: 4, name: "ጤፍ"),
Plate(id: 5, name: "ማር"),
Plate(id: 6, name: "ሰላጣ"),
Plate(id: 7, name: "ብሮኮሊ"),
Plate(id: 8, name: "አበባ ጐመን"),
Plate(id: 9, name: "ካሮት"),
Plate(id: 10, name: "ቲማቲም"),
Plate(id: 11, name: "ቱና"),
Plate(id: 12, name: "ዝኩኒ"),
Plate(id: 13, name: "አጃ"),
Plate(id: 14, name: "የገብስ ዳቦ"),
Plate(id: 15, name: "ሱፍ"),
Plate(id: 16, name: "መኮረኒ"),
Plate(id: 17, name: "ፓስታ"),
Plate(id: 18, name: "ሩዝ"),
Plate(id: 19, name: "ዶሮ"),
Plate(id: 20, name: "አቮካዶ"),
Plate(id: 21, name: "ኩከምበር"),
Plate(id: 22, name: "እንቁላል"),
Plate(id: 23, name: "ወተት"),
Plate(id: 24, name: "እርጐ"),
Plate(id: 25, name: "ጐመን"),
Plate(id: 26, name: "አሳ"),
Plate(id: 27, name: "እንጆሪ"),
Plate(id: 28, name: "ሽሮ"),
Plate(id: 29, name: "አፕል"),
Plate(id: 30, name: "እንጀራ"),
Plate(id: 31, name: "አተር ክክ"),
Plate(id: 32, name: "ሽንኩርት"),
Plate(id: 33, name: "በርበሬ"),
Plate(id: 34, name: "አፕል"),
];
final _items = _food
    .map((food) => MultiSelectItem<Plate>(food," ${food.name} "))
    .toList();

enum Packages {basic,standard,premium}

class _PlaceOrderState extends State<PlaceOrder> {

  List _selectedPlate = [];
  int page = 0;
  List _choices = ['Weight loss','Weight maintain', 'Weight gain'];
  List _choicestips = ['Get lean','Optimize your diet', 'Build muscle'];
  int _choiceIndex = 1;
  String alergies = '';
  Packages? _selectedContract = Packages.basic;
  bool paid = false;
  bool taped = false;
  late Payment txnDetails;
  String txRef = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNamectrl = TextEditingController();
  TextEditingController lastNamectrl = TextEditingController();
  TextEditingController phonectrl = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffececec),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            page == 0 ? Navigator.pop(context) : setState(() => page = page - 1);
          },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Icon(Icons.radio_button_checked, color: Colors.green,),
          Text('----------', style: TextStyle(color: page == 0 ? Colors.grey : Colors.green),),
          Icon(page == 0 ? Icons.radio_button_unchecked : Icons.radio_button_checked,
            color: page == 0 ? Colors.grey : Colors.green,),
          Text('----------', style: TextStyle(color: page == 0 || page == 1 ? Colors.grey : Colors.green),),
          Icon(page == 0 || page == 1 ? Icons.radio_button_unchecked : Icons.radio_button_checked,
            color: page == 0 || page == 1 ? Colors.grey : Colors.green,),
        ],),
      ),
      body:
      page == 0 ? Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0,bottom: 15),
                child: Text('Select a plan to proceed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              ),
              Center(child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildChoiceChips(),
              )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Your weight goal',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600 ),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                child: TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: 'Enter your weight goal'),
                    validator: (val) => val!.isEmpty ? 'Enter your weight goal' : null,
                    onChanged: (val){
                      setState(() => alergies = val);
                    }

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xd3ffffff),
                    border: Border.all(
                      color: Colors.white60,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: <Widget>[
                      MultiSelectBottomSheetField(
                        buttonIcon: Icon(Icons.add),
                        separateSelectedItems: true,
                        initialChildSize: 0.7,
                        maxChildSize: .7,
                        listType: MultiSelectListType.CHIP,
                        initialValue: _selectedPlate,
                        searchable: true,
                        itemsTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400, fontSize: 20),
                        selectedItemsTextStyle: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600, fontSize: 20),
                        buttonText: Text("Select prefered foods",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 18),),
                        title: Text("Plate"),
                        items: _items,
                        onConfirm: (values) {
                          for(int i = 0; i < _selectedPlate.length; i++ ){
                            _selectedPlate[0];
                            print(_selectedPlate[i].name);
                          }
                          print(values);
                          setState(() {
                            _selectedPlate = values;
                          });
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          alignment: Alignment.center,
                          onTap: (value) {
                            setState(() {
                              _selectedPlate.remove(value);
                            });
                          },
                        ),
                      ),
                      _selectedPlate.isEmpty
                          ? Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Center(
                            child: Text(
                              "None selected",
                              style: TextStyle(color: Colors.red),
                            ),
                          ))
                          : Container(
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Wrap(
                    children: [
                      Center(child: Icon(Icons.warning, color: Colors.redAccent,size: 30,)),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(.1),
                            border: Border.all(
                              color: Colors.redAccent.withOpacity(.5),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('We are not liable for any health issues that may arise because of alergies. \n'
                              'If you have any serious alergies we reccomend you physically consult a nutrition planner. ',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(
                                0xDD2A2323)),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ) :
      page == 1 ? Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Select contract', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            color: Color(0xffde7165),
                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Basic', style: TextStyle(color:Colors.white,fontWeight: FontWeight.w700, fontSize: 20),),
                            ))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: Colors.lightGreen,),
                              Text(' Meal plan for 1 month', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                            ],
                          )),
                        ),
                        Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.values[2],
                          children: [
                            Text('800 ', style: TextStyle(color:Colors.grey[700],fontWeight: FontWeight.w600, fontSize: 30),),
                            Text('ETB', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                          ],
                        ))
                      ],
                    ),),
                ),
                leading: Transform.scale(
                  scale: 1.5,
                  child: Radio(
                    value: Packages.basic,
                    groupValue: _selectedContract,
                    onChanged: (Packages? value) {
                      setState(() {
                        _selectedContract = value;
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                title:  Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            color: Color(0xff49b081),
                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Standard', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700, fontSize: 20),),
                            ))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: Colors.lightGreen,),
                              Text(' Meal plan for 3 month', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                            ],
                          )),
                        ),
                        Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.values[2],
                          children: [
                            Text('2200 ', style: TextStyle(color:Colors.grey[700],fontWeight: FontWeight.w600, fontSize: 30),),
                            Text('ETB', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                          ],
                        ))
                      ],
                    ),),
                ),
                leading: Transform.scale(
                  scale: 1.5,
                  child: Radio(
                    value: Packages.standard,
                    groupValue: _selectedContract,
                    onChanged: (Packages? value) {
                      setState(() {
                        _selectedContract = value;
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            color: Color(0xff56628d),
                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Premium', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700, fontSize: 20),),
                            ))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: Colors.lightGreen,),
                              Text(' Meal plan for 6 month', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                            ],
                          )),
                        ),
                        Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.values[2],
                          children: [
                            Text('4000 ', style: TextStyle(color:Colors.grey[700],fontWeight: FontWeight.w600, fontSize: 30),),
                            Text('ETB', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                          ],
                        ))
                      ],
                    ),),
                ),
                leading: Transform.scale(
                  scale: 1.5,
                  child: Radio(
                    value: Packages.premium,
                    groupValue: _selectedContract,
                    onChanged: (Packages? value) {
                      setState(() {
                        _selectedContract = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

      ) :
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Payment', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Form(
                key: _formKey,
                child:
              Column(
                children: [
                  TextFormField(
                controller: firstNamectrl,
                decoration: textinputdecoration.copyWith(
                  hintText: 'First name',
                  hintStyle: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
                TextFormField(
                  controller: lastNamectrl,
                  decoration: textinputdecoration.copyWith(
                    hintText: 'Last name',
                    hintStyle: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 12,),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name ';
                    }
                    return null;
                  },
                ),
                  TextFormField(
                  controller: phonectrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: textinputdecoration.copyWith(hintText: 'Phone number',
                      hintStyle: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 12,),),
                    validator: (val) => val!.length < 9 || val!.length > 10 ? 'Please enter a valid phone number ' : null,
                ),
                  TextButton(
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          final u = await Paydartchappa(firstNamectrl.text, lastNamectrl.text, phonectrl.text);
                          await showDialog(context: context,
                              builder: (context) => AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: Container(
                                  width: MediaQuery.of(context).size.width * .85,
                                  child: WebviewScaffold(
                                      appBar: AppBar(
                                        leading: IconButton(
                                          onPressed: () async{
                                            Navigator.pop(context);
                                            await checktxn();
                                          },
                                          icon: Icon(Icons.arrow_back_rounded),
                                        ),
                                        backgroundColor: Colors.black54,
                                      ),
                                      url: (u).toString()),
                                ),
                                // Container(
                                //   child: TextButton(
                                //     onPressed: (){
                                //       launchUrl(u);
                                //     },
                                //     child: Text('Proceed to chappa'),),
                                // ),

                              ));
                          final flutterWebviewPlugin = FlutterWebviewPlugin();

                          flutterWebviewPlugin.onUrlChanged.listen((u) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0
                      ),
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .42,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 5),
                              Text('Pay with ', style: TextStyle(color: Colors.lightGreen,
                                  fontWeight: FontWeight.w700, fontSize: 22),),
                              Image.asset('Assets/img_6.png'),
                              SizedBox(height: 2),
                            ],
                          ),
                        ),
                      )),

                ],
              )),
            ),
            // TextButton(onPressed: paid == false ? null :() async{
            //
            // }, child: Text('Finish order'))
          ],
        ),
      ),

        floatingActionButton:
        FloatingActionButton.extended(
            onPressed: () async{
              if(page == 2) {
              final user = Provider.of<UserFB?>(context, listen: false);
              setState(() {
                taped = true;
              });
              bool check = await checktxn();
              if (check) {
                List foods = [];
                for(int i = 0; i < _selectedPlate.length; i++ ){
                  foods.add(_selectedPlate[i].name);
                }
                print('finalizing');
                await DatabaseService(uid: user!.uid).makeOrder(
                    _choices[_choiceIndex],
                    foods,
                    _selectedContract.toString().substring(9),
                    txnDetails);
                setState(() {
                  taped = false;
                });
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BottomTab(index: 1)));
              }
            }
             if(page != 2){
              setState(() {
                page++;
              });
            }
          },
            backgroundColor: Colors.lightGreen,
            label:page == 2 && taped ? CircularProgressIndicator() : Text( page == 2 ? 'Finish order' :'Next')),
    );
  }

  Widget _buildSelectContract() {
    return Column(
      children: [

      ],
    );

  }

  Widget _buildChoiceChips() {
    return Center(
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width * .8,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _choices.length,
          separatorBuilder: (BuildContext context, int index) { return Text(' '); },
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: ChoiceChip(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(1),
                label: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      SizedBox(height: 5,),
                      Text(_choices[index], style: TextStyle(color:Colors.black,fontWeight: FontWeight.w700, fontSize: 13),),
                      Text('Plan', style: TextStyle(color:Colors.black,fontWeight: FontWeight.w700, fontSize: 12)),
                      SizedBox(height: 15,),
                      Text(_choicestips[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10),),
                    ]),
                selected: _choiceIndex == index,
                selectedColor: Color(0xb58fbfe1),
                backgroundColor: Colors.white,
                onSelected: (bool selected) {
                  setState(() {
                    _choiceIndex = selected ? index : 0;
                  });
                },
                // backgroundColor: Colors.green,
                labelStyle: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
int amount = 0;
  Paydartchappa(firstName, lastName, phoneNumber) async{
    setState((){
      txRef = generatetxRef();
    });
    if(_selectedContract.toString().substring(9) == "Basic") setState(() => amount = 800);
    if(_selectedContract.toString().substring(9) == "Standard") setState(() => amount = 2200);
    if(_selectedContract.toString().substring(9) == "Premium") setState(() => amount = 4000);
    var headers = {
      'Authorization': 'Bearer CHASECK_TEST-vCHsrkKC3ZThcyPZ6dXsH254LmqNK5u6',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://api.chapa.co/v1/transaction/mobile-initialize'));
    request.body = json.encode({
      "amount":(_selectedContract.toString().substring(9) == "Basic") ? "800": _selectedContract.toString().substring(9) == "Standard" ? "2200" : "4000",
      "currency": "ETB",
      "email": "example@gmail.com",
      "first_name": "${firstName}",
      "last_name": "${lastName}",
      "phone_number": "${phoneNumber}",
      "tx_ref": txRef,
      "named_route_fallBack": '/place', // fall back route name
      "callback_url": "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60",
      // "return_url": "/place",
      "customization[title]": "Payment for my favourite merchant",
      "customization[description]": "I love online payments"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();
      Map r = jsonDecode(res);
      // res as Map;
      print(r['data']['checkout_url']);
      Uri u = Uri.parse(r['data']['checkout_url']);
      return u;
    }
    else {
    print(response.reasonPhrase);
    print('Failed');
    }

  }

  checktxn() async{
    var headers = {
      'Authorization': 'Bearer CHASECK_TEST-vCHsrkKC3ZThcyPZ6dXsH254LmqNK5u6'
    };
    var request = http.Request('GET', Uri.parse('https://api.chapa.co/v1/transaction/verify/${txRef}'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();
      Map r = jsonDecode(res);
      print(r['status']);
      if( r['status'] == 'success'){
        setState(() {
          txnDetails = Payment(
              status: r['status'],
              amount: r['data']['amount'],
              date: r['data']['created_at'],
              email: r['data']['email'],
              fullName: r['data']['first_name'] + r['data']['last_name'],
              txRef: r['data']['tx_ref']);
          paid = true;
        });
        return true;
      }
      else {
        return false;
      }
    }
    else {
    print(response.reasonPhrase);
    return false;
    }
  }

  Paychapa() {
    Chapa.paymentParameters(
      context: context, // context
      publicKey: 'CHAPUBK_TEST-OlS6DHT5O1cuE854j4Dp3bdBjSCp9nHC',
      currency: 'ETB',
      amount: '200',
      email: 'example@gmail.com',
      firstName: 'Kalkidan',
      lastName: 'Abere',
      txRef: 'test3',
      title: 'title',
      desc:'desc',
      namedRouteFallBack: '/place', // fall back route name
    );

  }

  String generatetxRef() {
    var r = Random();
    const _chars = '0123456789';
    return List.generate(8, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
}
