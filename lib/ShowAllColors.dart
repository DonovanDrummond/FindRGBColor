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
  late List<Widget> DrawerItems = [_DrawerColorView, _DrawerGeneralColorView];
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
              appBar: AppBar(),
              drawer: Drawer(
                  child: SafeArea(
                child: Column(
                  children: [...DrawerItems],
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
      default:
        {
          return Scaffold(
              appBar: AppBar(),
              drawer: Drawer(
                  child: SafeArea(
                child: Column(
                  children: [...DrawerItems],
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

  Widget get _DrawerGeneralColorView {
    return MaterialButton(
      onPressed: () => setState(() {
        this.widget.TypeOfColorViews = ColorViewType.general;
      }),
      child: Container(child: Text("General")),
    );
  }

  Widget get _DrawerColorView {
    return MaterialButton(
      onPressed: () => setState(() {
        this.widget.TypeOfColorViews = ColorViewType.Default;
      }),
      child: Container(child: Text("Regular")),
    );
  }
}
