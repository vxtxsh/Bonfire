import 'package:flutter/material.dart';

class ActivityIcon extends StatelessWidget {
  String image;
  String name;
  Color colour;
  ActivityIcon(this.image,this.name,this.colour);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 65,
      child: Column(children:<Widget>[Image.asset(image,height: 45,width: 45,),Text(name,style: TextStyle(color: Colors.white),)],),
      decoration: BoxDecoration(border:Border.all(color: colour),)
    );
  }
}