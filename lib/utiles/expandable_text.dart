import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utiles/dimenstions.dart';
import 'package:food_delivery/utiles/small_text.dart';

class ExpandableText extends StatefulWidget {

  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {

  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  // 932 / 190 = 4.9
  double textHeight = Dimenstions.heightScreen/4.9;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(title: firstHalf):Column(
        children: [
          SmallText(title: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf),spacing: 0.5, lineHeight: 1.5, size: Dimenstions.text14),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText =! hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(title: hiddenText?"See more":"See less", colors: Colors.grey.shade800, spacing: 0.5, lineHeight: 1.5, size: Dimenstions.text18-2,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: Colors.grey.shade800,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
