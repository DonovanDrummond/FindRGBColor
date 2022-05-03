//import page
export 'dart:typed_data';
export 'package:camera/camera.dart';
export 'package:flutter/material.dart';
export 'dart:async';
export 'dart:io';
export 'package:flutter/foundation.dart';
//pages
export 'main.dart';
export 'ShowWhereOnImage.dart';
export 'ShowAllColors.dart';

import 'package:flutter/material.dart';

double ColorWidgetSize = 100;

Widget GreneralColorWidget(Color PassColor, String ColorName) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(50),
    color: PassColor,
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        ColorName,
        style: TextStyle(
            color: PassColor.value <= 0xFF7FFFFF ? Colors.white : Colors.black),
      ),
    ),
  );
}

Widget ColorWidget(Color PassColor) {
  return Container(
    margin: const EdgeInsets.all(10),
    color: PassColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Red: " + PassColor.red.toString(),
          style: TextStyle(
              color:
                  PassColor.value <= 0xFF7FFFFF ? Colors.white : Colors.black),
        ),
        Text(
          "Green: " + PassColor.green.toString(),
          style: TextStyle(
              color:
                  PassColor.value <= 0xFF7FFFFF ? Colors.white : Colors.black),
        ),
        Text(
          "Blue: " + PassColor.blue.toString(),
          style: TextStyle(
              color:
                  PassColor.value <= 0xFF7FFFFF ? Colors.white : Colors.black),
        ),
      ],
    ),
  );
}

enum ColorViewType { Default, general, carousal }
