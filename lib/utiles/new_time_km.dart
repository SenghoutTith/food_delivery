import 'package:flutter/material.dart';
import 'package:food_delivery/utiles/small_text.dart';
import 'dimenstions.dart';

class NewTimeKm extends StatelessWidget {

  Color? colors;

  NewTimeKm({
    super.key,
    this.colors = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: Colors.yellow,
                size: Dimenstions.icon15,
              ),
              SizedBox(
                width: Dimenstions.width5,
              ),
              SmallText(title: "New", colors: colors,),
              // Text('New'),
            ],
          ),
        ),
        SizedBox(
          width: Dimenstions.width10,
        ),
        Container(
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.greenAccent,
                size: Dimenstions.icon15,
              ),
              SizedBox(
                width: Dimenstions.width5,
              ),
              SmallText(title: "1.7km", colors: colors,),
            ],
          ),
        ),
        SizedBox(
          width: Dimenstions.width10,
        ),
        Container(
          child: Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                color: Colors.brown,
                size: Dimenstions.icon15,
              ),
              SizedBox(
                width: Dimenstions.width5,
              ),
              SmallText(title: "32mins", colors: colors,),
            ],
          ),
        ),
      ],
    );
  }
}
