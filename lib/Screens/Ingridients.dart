import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class IngredientsPage extends StatefulWidget {
  final String foodName = 'Enkulal';
  final String imageURL = 'https://img.jamieoliver.com/jamieoliver/recipe-database/oldImages/large/576_1_1438868377.jpg?tr=w-800,h-1066';
  final List<Ingredient> ingredients = [
    Ingredient(name: 'eggs', calories: 20, amount: '2 large'),
    Ingredient(name: 'zeyet', calories: 50, amount: '2 tea spoons'),
    Ingredient(name: 'shenkurt', calories: 100, amount: '2 medium'),
    Ingredient(name: 'timatim', calories: 200, amount: '3 medium'),
  ];

  // IngredientsPage({required this.foodName, required this.imageURL, required this.ingredients});

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  Color primaryColor = Colors.white;
  Color complementColor = Colors.black;
  double _totalCalories = 0;

  @override
  void initState() {
    super.initState();
    _getDominantColor();
    _calculateTotalCalories();
  }

  Future<void> _getDominantColor() async {
    PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(NetworkImage(widget.imageURL));
    setState(() {
      primaryColor = paletteGenerator.dominantColor?.color ?? Colors.white;
      complementColor = paletteGenerator.dominantColor?.titleTextColor ?? Colors.black;
    });
  }
  void _calculateTotalCalories() {
    double calculatedCalories = 0;
    for(int i = 0; i < widget.ingredients.length ; i++){
    calculatedCalories += widget.ingredients[i].calories;

    String inputString = widget.ingredients[i].amount;
    int indexOfSpace = inputString.indexOf(' ');
    String substring = inputString.substring(0, indexOfSpace);

    int amountsubed = int.parse(substring);
    amountsubed * widget.ingredients[i].calories;
    print(substring); // Output: "Hello"

    }
    setState(() {
      _totalCalories = calculatedCalories;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_rounded, size: 30,),
            onPressed: () {
              Navigator.pop(context);
            },
            color: complementColor, // Change the color of the back button here
          ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.3,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageURL),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.7),
                    primaryColor.withOpacity(0.2),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.foodName,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: complementColor.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ingredients',
                          style: TextStyle(
                            fontSize: 20,
                            color: complementColor.withOpacity(0.7),
                          ),
                        ),
                        Text('${_totalCalories.toInt()} cal', style: TextStyle(
                          fontSize: 17,
                          color: complementColor.withOpacity(0.7),
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: primaryColor.withOpacity(0.1),
              child: ListView.builder(
                itemCount: widget.ingredients.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.ingredients[index].name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            widget.ingredients[index].amount,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class Ingredient {
  final String name;
  final double calories;
  final String amount;

  Ingredient({required this.name, required this.calories, required this.amount});
}
