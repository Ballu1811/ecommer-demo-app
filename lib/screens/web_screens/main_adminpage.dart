import 'package:flutter/material.dart';

class WebAdminPage extends StatelessWidget {
  const WebAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Container(
            color: Colors.amber,
          )),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
