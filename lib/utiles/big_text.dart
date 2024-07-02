import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utiles/dimenstions.dart';

class BigText extends StatelessWidget {
  final String title;
  Color? colors;
  double size;
  TextOverflow textOverflow;
  BigText({
    super.key,
    required this.title,
    this.colors=Colors.black,
    this.textOverflow=TextOverflow.ellipsis,
    this.size=0
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      style: TextStyle(
        overflow: textOverflow,
        fontWeight: FontWeight.bold,
        color: colors,
        fontSize: size==0?Dimenstions.text18:size,
      ),
    );
  }
}
