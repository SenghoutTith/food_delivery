import 'package:flutter/material.dart';
import 'package:food_delivery/utiles/expandable_text.dart';
import 'package:food_delivery/utiles/small_text.dart';
import 'big_text.dart';
import 'dimenstions.dart';
import 'new_time_km.dart';

class FoodDetail extends StatelessWidget {
  final String title;
  final String description;
  const FoodDetail({
    super.key,
    required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          title: title,
          size: Dimenstions.text20,
        ),
        SizedBox(height: Dimenstions.height5),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    color: Colors.black,
                    size: Dimenstions.icon15,
                  )),
            ),
            SizedBox(width: Dimenstions.width10,),
            Text('5'),
            SizedBox(width: Dimenstions.width5,),
            Text('1204 comments'),
          ],
        ),

        SizedBox(
          height: Dimenstions.height15,
        ),
        NewTimeKm(),
        SizedBox(
          height: Dimenstions.height20,
        ),
        BigText(title: 'Description'),
        SizedBox(
          height: Dimenstions.height5,
        ),
        Expanded(
          child: SingleChildScrollView(
              child: ExpandableText(text: description),
          ),
        ),
      ],
    );
  }
}
