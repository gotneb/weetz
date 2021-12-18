import 'package:flutter/material.dart';
import 'package:weetz/utils/styles.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 0.7 * height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/space-shuttle-512.png',
            width: 0.6 * width,
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
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
  }
}
