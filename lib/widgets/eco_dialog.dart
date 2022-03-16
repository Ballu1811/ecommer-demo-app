import 'package:flutter/material.dart';
import 'package:food_app_demo/widgets/eco_button.dart';

class EcoDialogue extends StatelessWidget {
  final String? title;
  const EcoDialogue({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      actions: [
        EcoButton(
          title: 'CLOSE',
          onPress: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
