import 'Dependencies.dart';
import 'package:image/image.dart' as img;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(
        camera: cameras.first,
        title: "Cam",
      ),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.camera})
      : super(key: key);

  final String title;
  final CameraDescription camera;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController _cameraController;
  List<ShowImageColorWidget> listofColorWidgets = [];
  List<Color> ListofColor = [];
  static double ColorWidgetSize = 100;
  Uint8List? imageInMemory;
  bool processingData = false;
  double progressMade = 0.0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.max);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: processingData
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: FutureBuilder(
                        future: _cameraController.initialize(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return CameraPreview(_cameraController);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width * .5,
                    height: MediaQuery.of(context).size.height * .5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    MaterialButton(
                      onPressed: () async {
                        print((1 << 16).toString() + "d");
                        print((1 << 2).toString() + "d");
                        print((1 << 3).toString() + "d");

                        try {
                          img.Image? image;

                          setState(() {
                            listofColorWidgets = [];
                            processingData = true;
                            progressMade = 0;
                          });

                          await _cameraController
                              .takePicture()
                              .then((value) async {
                            image = img.decodeImage(await value.readAsBytes());
                            for (var y = 0; y < image!.height; y++) {
                              for (var x = 0; x < image!.width; x++) {
                                int pixel = image!.getPixelSafe(x, y);
                                int b = (pixel >> 16) & 0xFF;
                                int r = (pixel & 0xFF) << 16;
                                addDifferentColor(
                                    Color((pixel & 0xFF00FF00) | b | r));
                              }
                            }
                          });
                          for (var item in ListofColor) {
                            listofColorWidgets.add(ShowImageColorWidget(
                                item, Size(ColorWidgetSize, ColorWidgetSize)));
                          }

                          print("done");
                          setState(() {
                            processingData = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowAllColors(
                                        ListOfColorWidgets: listofColorWidgets,
                                      )));
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .2,
                        height: MediaQuery.of(context).size.height * .1,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(width: 1)),
                        child: const Text(
                          "Take Picture",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // if (imageInMemory != null)
                    //   Container(
                    //     width: MediaQuery.of(context).size.width * .1,
                    //     height: MediaQuery.of(context).size.height * .1,
                    //     margin: const EdgeInsets.all(5),
                    //     child: Image.memory(imageInMemory!),
                    //   ),
                  ]),
                ],
              )));
  }

  void addDifferentColor(Color temp) {
    if (ListofColor.contains(temp)) {
      return;
    }
    ListofColor.add(temp);
  }
}
