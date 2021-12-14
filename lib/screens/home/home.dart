import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:weetz/screens/home/header.dart';
import 'package:weetz/utils/styles.dart';

class HomeScreen extends StatelessWidget {
  static const url = 'https://www.google.com/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final main = Container(
      width: width,
      height: 0.7 * height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/boxes.png',
            height: 0.35 * height,
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange[800],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: const [
                Text(
                  'Nenhum download feito',
                  style: Style.information,
                ),
                Text(
                  'Que tal inicial um?',
                  style: Style.information,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final body = ListView(
      children: [
        const Header(),
        main,
      ],
    );

    return Scaffold(
      body: body,
    );
  }
}
