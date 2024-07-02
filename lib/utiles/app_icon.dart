import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utiles/colors.dart';
import 'package:food_delivery/utiles/dimenstions.dart';

class AppIcon extends StatelessWidget {

  final IconData? icon;
  Color? color;
  Color? backgroundColor;
  double? size;

  AppIcon({
    super.key,
    required this.icon,
    this.color=AppColors.mainColor,
    this.backgroundColor=CupertinoColors.inactiveGray,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size!/2),
        color: backgroundColor==CupertinoColors.inactiveGray?CupertinoColors.inactiveGray:backgroundColor
      ),
      child: Icon(
        icon,
        color: color==AppColors.mainColor?AppColors.mainColor:color,
        size: Dimenstions.icon15,
      ),
    );
  }
}
