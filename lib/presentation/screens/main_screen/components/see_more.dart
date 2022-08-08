import 'package:flutter/material.dart';
import 'package:news_app/constants/app_constants.dart';

class SeeMore extends StatelessWidget {
  const SeeMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: const [
          Text(
            seeMore,
            style: TextStyle(
                color: secondaryColor, fontSize: 12, fontWeight: mediumFont),
          ),
          Icon(
            Icons.chevron_right,
            color: secondaryColor,
          )
        ],
      ),
    );
  }
}
