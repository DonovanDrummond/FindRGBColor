import 'dart:developer';

import 'Dependencies.dart';
import 'package:image/image.dart' as img;

class ShowWhereOnImage extends StatefulWidget {
  ShowWhereOnImage(
      {Key? key,
      required this.ListOfColor,
      required this.theImage,
      required this.thePicture,
      this.TypeOfColorViews = ColorViewType.Default})
      : super(key: key);
  ColorViewType TypeOfColorViews;
  List<List<Color>> ListOfColor;
  Image thePicture;
  img.Image theImage;

  @override
  State<ShowWhereOnImage> createState() => _ShowWhereOnImageState();
}

class _ShowWhereOnImageState extends State<ShowWhereOnImage> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Stack(children: [
              Image(
                  image: widget.thePicture.image,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.height * .7 + 1),
              Positioned(
                  top: (value.toDouble() *
                      (MediaQuery.of(context).size.height *
                          .7 /
                          widget.theImage.height.toDouble())),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 1,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red),
                    ),
                  ))
            ]),
          ),
          SliderTheme(
            data:
                SliderThemeData(showValueIndicator: ShowValueIndicator.always),
            child: Slider(
              value: value.toDouble(),
              activeColor: Colors.red,
              inactiveColor: Colors.black26,
              label: value.round().toString(),
              min: 0,
              max: widget.theImage.height.toDouble(),
              onChanged: (double changedValue) {
                log("the image h ${widget.theImage.height.toDouble()}");
                log("the piture h ${MediaQuery.of(context).size.height * .7}");
                log("${(value.toDouble() * (MediaQuery.of(context).size.height * .7 / widget.theImage.height.toDouble()))}");
                setState(() {
                  value = changedValue.toInt();
                });
              },
            ),
          ),
          MaterialButton(
              child: Container(
                color: Colors.white,
                child: Text("Confirm", style: TextStyle(color: Colors.black)),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowAllColors(
                              ListOfColor: widget.ListOfColor[value],
                              TypeOfColorViews: widget.TypeOfColorViews,
                            )));
              })
        ],
      ),
    );
  }
}
