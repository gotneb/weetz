import 'package:flutter/material.dart';
import 'package:weetz/utils/styles.dart';

class SearchPin extends StatelessWidget {
  const SearchPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTap: () {},
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.orange[800],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[900]!,
              blurRadius: 2,
            )
          ],
        ),
        child: const Center(
            child: Text(
          'Go',
          style: Style.button,
        )),
      ),
    );

    final input = TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Pin...',
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900]!,
            offset: Offset(1, 1),
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 10),
          Flexible(child: input),
          const SizedBox(width: 10),
          button,
        ],
      ),
    );
  }
}
