import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utiles/big_text.dart';
import 'package:food_delivery/utiles/dimenstions.dart';
import 'package:food_delivery/utiles/small_text.dart';

import '../utiles/colors.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimenstions.height55),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: Dimenstions.width10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(title: 'Cambodia'),
                Row(
                  children: [
                    SmallText(title: 'Phnom Penh'),
                    const Icon(Icons.arrow_drop_down, color: Colors.black,),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: Dimenstions.width10, top: Dimenstions.height5, bottom: Dimenstions.height5),
            width: Dimenstions.height55,
            height: Dimenstions.height55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimenstions.height55/2),
              color: AppColors.mainColor,
            ),
            child: const Icon(Icons.search, color: Colors.white,),
          )
        ],
      ),
    );
  }
}
