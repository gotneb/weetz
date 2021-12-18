import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    required this.search,
    Key? key,
  }) : super(key: key);

  final Widget search;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 0.3 * height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: search,
          ),
        ],
      ),
    );
  }
}
