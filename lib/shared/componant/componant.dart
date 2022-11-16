import 'package:flutter/material.dart';

Widget gridItem({
  required Widget icon,
  required String lable,
})=>Container(
decoration: BoxDecoration(
border: Border.all(
width: 2,
color: Colors.lightBlueAccent,
),
shape: BoxShape.circle,
color: Colors.white,

boxShadow: [
  BoxShadow(
    color: Colors.grey,
    blurRadius: 6,
    spreadRadius: .01,
    offset: Offset(0, 5)
  )
]
),

child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
icon,
SizedBox(height: 4,),
Text(lable,),
],
),
);