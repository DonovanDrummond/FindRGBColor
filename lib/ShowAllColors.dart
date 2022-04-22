import 'Dependencies.dart';

class ShowAllColors extends StatelessWidget {
  ShowAllColors({Key? key, required this.ListOfColorWidgets}) : super(key: key);
  List<ShowImageColorWidget> ListOfColorWidgets;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: ListOfColorWidgets.length,
      itemBuilder: (context, index) {
        return ListOfColorWidgets[index].ShowMe;
      },
    ));
  }
}
