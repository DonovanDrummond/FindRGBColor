export 'package:flutter/material.dart';
export 'dart:ffi';
export 'dart:typed_data';
export 'package:convert/convert.dart';
export 'package:findcolors/ShowAllColors.dart';
export 'main.dart';
export 'package:camera/camera.dart';
export 'package:flutter/material.dart';
export 'dart:async';
import 'package:flutter/material.dart';

class ShowImageColorWidget {
  final Color MyColor;
  final Size MySize;
  bool showdata = true;
  ShowImageColorWidget(this.MyColor, this.MySize);
  Widget get ShowMe {
    return Container(
      margin: const EdgeInsets.all(10),
      color: MyColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Red: " + MyColor.red.toString()),
          Text("Green: " + MyColor.green.toString()),
          Text("Blue: " + MyColor.blue.toString()),
        ],
      ),
    );
  }
}

class Position {
  double x;
  double y;
  Position([this.x = 0, this.y = 0]);
}
