import 'package:flutter/material.dart';
import 'package:weetz/components/search_pin.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    const gradient = LinearGradient(
      colors: [
        Color.fromRGBO(252, 86, 3, 1),
        Color.fromRGBO(242, 163, 78, 1),
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: width,
      height: 0.3 * height,
      decoration: const BoxDecoration(
        gradient: gradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SearchPin(),
        ],
      ),
    );
  }
}
