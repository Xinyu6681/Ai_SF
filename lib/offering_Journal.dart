import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'EventListPage.dart';
import 'EventPage.dart';


class offeringPage extends StatefulWidget {
  @override
  _offeringPageState createState() => _offeringPageState();
}

class _offeringPageState extends State<offeringPage> {
  String _text = 'What do you want to offer?';
  String _currentDate = '';

  void _updateCurrentDate() {
    final now = DateTime.now();
    final formatDate = DateFormat('MMM d, y').format(now);
    setState(() {
      _currentDate = formatDate;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentDate,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20), // Add some spacing
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => offeringListPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  _text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


