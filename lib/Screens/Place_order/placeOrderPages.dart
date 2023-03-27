import 'package:chapasdk/chapa_payment%20initializer.dart';
import 'package:flutter/material.dart';
import 'package:gebeta/Model/Decorations.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class selectFood extends StatefulWidget {
  const selectFood({Key? key}) : super(key: key);

  @override
  State<selectFood> createState() => _selectFoodState();
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
Plate(id: 1, name: "Shiro"),
Plate(id: 2, name: "Meser"),
Plate(id: 3, name: "Salad"),
Plate(id: 4, name: "Sega wet"),
Plate(id: 5, name: "Gomen"),
Plate(id: 6, name: "Tebs"),
Plate(id: 7, name: "Pasta"),
];
final _items = _food
    .map((food) => MultiSelectItem<Plate>(food, food.name))
    .toList();

enum Packages {basic,standard,premium}

class _selectFoodState extends State<selectFood> {

  List _selectedPlate = [];
  int page = 0;
  List _choices = ['Weight loss','Weight maintain', 'Weight gain'];
  List _choicestips = ['Get lean','Optimize your diet', 'Build muscle'];
  int _choiceIndex = 1;
  String alergies = '';
  Packages? _selected = Packages.basic;


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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                        initialChildSize: 0.4,
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: Text("Select prefered foods",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 18),),
                        title: Text("Plate"),
                        items: _items,
                        onConfirm: (values) {
                          setState(() {
                            _selectedPlate = values;
                          });
                        },
                        chipDisplay: MultiSelectChipDisplay(
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
                          : Container(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Do you have any alergies we need to know about?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600 ),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                child: TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: 'Enter any alergies'),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val){
                      setState(() => alergies = val);
                    }

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
                    groupValue: _selected,
                    onChanged: (Packages? value) {
                      setState(() {
                        _selected = value;
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
                    groupValue: _selected,
                    onChanged: (Packages? value) {
                      setState(() {
                        _selected = value;
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
                    groupValue: _selected,
                    onChanged: (Packages? value) {
                      setState(() {
                        _selected = value;
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
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Pay with Chapa', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
              ElevatedButton(onPressed: (){
                Paychapa();
              }, child: Text('Pay'))
            ],
          ),
        ),
      ),

        floatingActionButton:
        FloatingActionButton.extended(
            onPressed: (){
              setState(() {
                page ++ ;
              });
            },
            backgroundColor: Colors.lightGreen,
            label: Text('Next')),
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

  Paychapa() {
    Chapa.paymentParameters(
      context: context, // context
      publicKey: 'CHAPUBK_TEST-OlS6DHT5O1cuE854j4Dp3bdBjSCp9nHC',
      currency: 'ETB',
      amount: '200',
      email: 'gebetnutrition12@gmail.com',
      firstName: 'Kalkidan',
      lastName: 'Abere',
      txRef: 'test123',
      title: 'title',
      desc:'desc',
      namedRouteFallBack: '/second', // fall back route name
    );
  }
}
