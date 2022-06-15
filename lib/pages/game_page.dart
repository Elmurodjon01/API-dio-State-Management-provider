import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_page_provider.dart';

class GamePage extends StatelessWidget {
  double? deviceHeight, deviceWidth;

  GamePageProvider? pageProvider;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context),
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(
      builder: (context) {
        pageProvider = context.watch<GamePageProvider>();
        if (pageProvider!.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceHeight! * 0.0,
                ),
                child: gameUi(),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget gameUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        questionText(),
        Column(
          children: [
            trueButton(),
            SizedBox(
              height: deviceHeight! * 0.01,
            ),
            falseButton(),
          ],
        ),
      ],
    );
  }

  Widget questionText() {
    return Text(
      pageProvider!.getCurrenQuestionText(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w400,),
    );
  }

  Widget trueButton() {
    return MaterialButton(
      onPressed: () {},
      color: Colors.green,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      child: const Text(
        'True',
        style: TextStyle(color: Colors.white, fontSize: 25.0),
      ),
    );
  }

  Widget falseButton() {
    return MaterialButton(
      onPressed: () {},
      color: Colors.red,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      child: const Text(
        'False',
        style: TextStyle(color: Colors.white, fontSize: 25.0),
      ),
    );
  }
}
