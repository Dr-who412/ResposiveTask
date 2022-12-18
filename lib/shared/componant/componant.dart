import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

Widget gridItem({
  required String? image,
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
mainAxisAlignment: MainAxisAlignment.end,
mainAxisSize: MainAxisSize.min,
children: [
  SizedBox(height: 6,),
  Expanded(
    flex: 3,
    child: Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black12,
        shape: BoxShape.circle,
      ),
      child: base64Decode(image.toString()).isEmpty
          ?  Icon(Icons.image,color: Colors.black54,)
          : Image.memory(base64Decode(image.toString()), ),
    ),
  ),
Expanded(
    flex: 1,
    child: Text(lable,)),
],
),
);