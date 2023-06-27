import 'package:flutter/material.dart';


class About_us extends StatelessWidget {
  // const About_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('About us'),
              backgroundColor: Colors.black12,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Gebeta, an Ethiopian-Based Nutrition Application!\n',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                          TextSpan(text: '\n',),
                          TextSpan(
                              text: 'Our nutrition application is designed to help you achieve your health goals through personalized meal plans based on Ethiopian-based dishes.'
                                  'Whether you\'re looking to lose weight, gain weight, or maintain your current weight, we\'ve got you covered.'
                                  'Here\'s a quick guide to getting started with our app:\n',
                              style: TextStyle(
                              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w300)),
                      TextSpan(
                        text: '\n1. Sign Up:\n',
                        style: TextStyle(
                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:   'Create an account on our app by providing the necessary information such as your name,'
                              ' email address, and password. Make sure to provide accurate details for a seamless experience.',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w300)),
                      TextSpan(
                          text:  '\n2. Choose Your Goal:\n',
                          style: TextStyle(
                              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:
                          'Select your desired goal from the available options: weight loss, weight gain, or weight maintenance.'
                              ' Each goal will have specific meal plans tailored to your needs.',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w300)),
                                  TextSpan(
                        text:    '\n3. Complete Your Profile:\n',
                        style: TextStyle(
                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:
                          'Fill out your profile by providing relevant details such as your age, gender, height, weight, and activity level.'
                              ' This information helps us generate personalized meal plans that suit your requirements.',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w300)),
                      TextSpan(
                          text: '\n4. Generate Meal Plan:\n',
                          style: TextStyle(
                              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:
                          'Once your profile is complete, our app will generate a customized meal plan based on Ethiopian-based dishes.'
                              ' The meal plan will be designed specifically for your chosen goal (weight loss, weight gain, or weight maintenance).',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w300)),
                                  TextSpan(
                        text: '\n5. Explore Ethiopian Dishes:\n',
                        style: TextStyle(
                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: 'Discover a wide range of delicious and nutritious Ethiopian-based dishes within our app.'
                              ' We provide detailed recipes, ingredient lists, and cooking instructions to help you prepare your meals easily.',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w300)),
                      TextSpan(
                          text: '\n6. Payment System:\n',
                          style: TextStyle(
                              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: 'Our app offers premium features and services for an enhanced experience.'
                              ' We have integrated the secure payment system, Chapa, to facilitate smooth and hassle-free transactions.'
                              ' You can access these premium features by selecting the payment option within the app.',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w300)),
                              TextSpan(
                          text:  '\n7. In-App Support:\n',
                          style: TextStyle(
                              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:   'If you have any questions or need assistance while using our app, our customer support team is just a message away.'
                              ' Feel free to reach out to us through the in-app support feature, and we\'ll be happy to help you.',
                          style: TextStyle(
                              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w300)),
                         TextSpan(
                          text: '\n\nRemember, while our app provides general nutrition recommendations,'
                              ' it is essential to consult with a qualified healthcare professional'
                              ' before making any significant changes to your diet or exercise routine.\n\n'
                              'We\'re excited to embark on this health journey with you! Start exploring the delicious Ethiopian-based meals'
                              ' and achieve your health goals with our nutrition application.',
                             style: TextStyle(
                              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w500)),
                        ]),),
                ),

              ],
            )
    );
  }


}
