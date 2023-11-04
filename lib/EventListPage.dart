import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class offeringListPage extends StatelessWidget {
  final List<String> buttonNames = [
    'Food',
    'Clothing',
    'Sleeping Bags',
    'Toilet Access',
    'Showering Facilities',
    'First-aid Kit',
    'OTC Pain Killers',
    'Flash Lights',
    'Smart Phones',
    'Smart Phone Chargers',
    'Electricity Outlets',
    'FREE Wifi Zones',
    'App Support',
    'Drug Abuse Support',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal List'),
      ),
      body: ListView(
        children: buttonNames
            .map(
              (buttonText) => ButtonItem(
            buttonText: buttonText,
            routeName: '/offeringeventDetail',
          ),
        )
            .toList(),
      ),
    );
  }
}

class ButtonItem extends StatelessWidget {
  final String buttonText;
  final String routeName;

  ButtonItem({
    required this.buttonText,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (routeName.isNotEmpty) {
              Navigator.pushNamed(context, routeName, arguments: buttonText);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }
}
