import 'Dependencies.dart';

class ShowAllColors extends StatefulWidget {
  ShowAllColors(
      {Key? key,
      required this.ListOfColor,
      this.TypeOfColorViews = ColorViewType.Default})
      : super(key: key);
  ColorViewType TypeOfColorViews;
  List<Color> ListOfColor = [];
  @override
  State<ShowAllColors> createState() => _ShowAllColorsState();
}

class _ShowAllColorsState extends State<ShowAllColors> {
  List<Widget> listofColorWidgets = [];
  @override
  Widget build(BuildContext context) {
    for (var item in this.widget.ListOfColor) {
      listofColorWidgets.add(ColorWidget(item));
    }
    switch (this.widget.TypeOfColorViews) {
      case ColorViewType.general:
        {
          return Scaffold(
              appBar: defaultAppBar,
              drawer: Drawer(
                  child: SafeArea(
                child: Column(
                  children: [..._DrawerItems],
                ),
              )),
              body: SafeArea(
                child: GridView.count(
                  primary: false,
                  crossAxisCount: 2,
                  children: [...GeneralColorWidgetSorter],
                ),
              ));
        }
      case ColorViewType.carousal:
        {
          return Scaffold(
            appBar: defaultAppBar,
            drawer: Drawer(
                child: SafeArea(
              child: Column(
                children: [..._DrawerItems],
              ),
            )),
            body: Center(
              child: Container(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CarouselWidget(index);
                },
              )),
            ),
          );
        }
      default:
        {
          return Scaffold(
              appBar: defaultAppBar,
              drawer: Drawer(
                  child: SafeArea(
                child: Column(
                  children: [..._DrawerItems],
                ),
              )),
              body: SafeArea(
                child: ListView(
                  children: [...listofColorWidgets],
                ),
              ));
        }
    }
  }

  AppBar get defaultAppBar {
    return AppBar(
      actions: [
        MaterialButton(
          onPressed: (() => setState(() {
                Navigator.pop(context);
              })),
          child: const Text("BACK"),
        ),
      ],
    );
  }

  Widget CarouselWidget(int index) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        height: MediaQuery.of(context).size.height * .9,
        width: MediaQuery.of(context).size.width * .9,
        margin: EdgeInsets.only(left: 1, right: 1),
        color: widget.ListOfColor[index],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Red: " + widget.ListOfColor[index].red.toString(),
              style: TextStyle(
                  color: widget.ListOfColor[index].value <= 0xFF7FFFFF
                      ? Colors.white
                      : Colors.black),
            ),
            Text(
              "Green: " + widget.ListOfColor[index].green.toString(),
              style: TextStyle(
                  color: widget.ListOfColor[index].value <= 0xFF7FFFFF
                      ? Colors.white
                      : Colors.black),
            ),
            Text(
              "Blue: " + widget.ListOfColor[index].blue.toString(),
              style: TextStyle(
                  color: widget.ListOfColor[index].value <= 0xFF7FFFFF
                      ? Colors.white
                      : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get GeneralColorWidgetSorter {
    List<Widget> temp = [];
    List<Color> UsedColors = [];
    this.widget.ListOfColor.forEach((element) {
      //red
      if (element.red >= 53 && element.blue <= 15.7 && element.green <= 25) {
        if (UsedColors.contains(Colors.red) == false) {
          temp.add(GreneralColorWidget(Colors.red, "Red"));
          UsedColors.add(Colors.red);
        }
      }
      //blue
      if (element.red <= 34 && element.blue >= 56 && element.green <= 49) {
        if (UsedColors.contains(Colors.blue) == false) {
          temp.add(GreneralColorWidget(Colors.blue, "Blue"));
          UsedColors.add(Colors.blue);
        }
      }
      //green
      if (element.red <= 34 && element.blue >= 28 && element.green >= 50) {
        if (UsedColors.contains(Colors.green) == false) {
          temp.add(GreneralColorWidget(Colors.green, "Green"));
          UsedColors.add(Colors.green);
        }
      }
      //maganeta
      if (element.value <= 0xFFFF00FF && element.value >= 0xFFa100c0) {
        if (UsedColors.contains(Color(0xFFFF00FF)) == false) {
          temp.add(GreneralColorWidget(Color(0xFFFF00FF), "Maganeta"));
          UsedColors.add(Color(0xFFFF00FF));
        }
      }
      //yellow
      if (element.value <= 0xFFFFFF00 && element.value >= 0xFFc0d300) {
        if (UsedColors.contains(Colors.yellow) == false) {
          temp.add(GreneralColorWidget(Colors.yellow, "Yellow"));
          UsedColors.add(Colors.yellow);
        }
      }
      //aqua
      if (element.value <= 0xFF00FFFF && element.value >= 0xFF0074a1) {
        if (UsedColors.contains(Color(0xFF00FFFF)) == false) {
          temp.add(GreneralColorWidget(Color(0xFF00FFFF), "aqua"));
          UsedColors.add(Color(0xFF00FFFF));
        }
      }
      //white
      if (element.computeLuminance() >= 128) {
        if (UsedColors.contains(Colors.white) == false) {
          temp.add(GreneralColorWidget(Colors.white, "White"));
          UsedColors.add(Colors.white);
        }
      }
      //Black
      else {
        if (UsedColors.contains(Colors.black) == false) {
          temp.add(GreneralColorWidget(Colors.black, "Black"));
          UsedColors.add(Colors.black);
        }
      }
    });
    return temp;
  }

  List<Widget> get _DrawerItems {
    List<Widget> drawerItems = [];
    drawerItems.add(ExpansionTile(
      title: const Text("View Color Type"),
      children: [
        for (ColorViewType item in ColorViewType.values)
          MaterialButton(
              child: Container(
                  height: MediaQuery.of(context).size.height * .04,
                  color: Colors.white,
                  child: Center(
                      child: Text("${item.name}",
                          style: TextStyle(color: Colors.black)))),
              onPressed: () => setState(() {
                    this.widget.TypeOfColorViews = item;
                  })),
      ],
    ));

    return drawerItems;
  }
}
