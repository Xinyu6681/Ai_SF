import 'package:flutter/material.dart';

class MainSelectionScreen extends StatelessWidget {
  void navigateToScreen(BuildContext context, String screen) {
    Navigator.pushNamed(context, screen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose an Option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => navigateToScreen(context, '/offeringPage'),
              child: Text('Offering'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigateToScreen(context, '/requestPage'),
              child: Text('Request'),
            ),
          ],
        ),
      ),
    );
  }
}
