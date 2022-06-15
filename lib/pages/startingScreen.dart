import 'package:flutter/material.dart';
import 'package:frivia/pages/game_page.dart';

class StartingScreen extends StatefulWidget {
  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override
  Widget build(BuildContext context) {
    double dvalue = 0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Frivia',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              'Easy',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Slider(
              divisions: 2,
              value: dvalue,
              onChanged: (double newValue) {
                setState(
                  () {
                    newValue = dvalue;
                  },
                );
              },
            ),
            MaterialButton(
              color: Colors.green,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(),
                ),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
