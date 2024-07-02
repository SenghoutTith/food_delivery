import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utiles/dimenstions.dart';

class SmallText extends StatelessWidget {
  final String title;
  double? spacing;
  double? lineHeight;
  Color? colors;
  double size;
  int? maxLine;
  TextOverflow? textOverflow;
  SmallText({
    super.key,
    required this.title,
    this.lineHeight,
    this.spacing,
    this.colors=Colors.black,
    this.textOverflow,
    this.maxLine,
    this.size=0
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLine,
      style: TextStyle(
        overflow: textOverflow,
        letterSpacing: spacing,
        height: lineHeight,
        color: colors==Colors.black?Colors.black:colors,
        fontSize: size==0?Dimenstions.text12:size,
      ),
    );
  }
}
