import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: 'Game Instructions'),
      body: Container(
        color: WHITE_COLOR,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListView.builder(
                itemCount: GAME_INSTRUCTIONS.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (buildContext, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('[${index+1}] ${GAME_INSTRUCTIONS[index]}',
                      textAlign: TextAlign.justify,
                      style: getTextStyleSettings(fontSize: FontSize.SMALL),),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
