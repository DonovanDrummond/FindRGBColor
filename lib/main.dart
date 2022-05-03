import 'dart:developer';
import 'package:image/image.dart' as img;
import 'Dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(
        camera: cameras.first,
        title: "World RGB",
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

double progressMadevalue = 0.0;

class _MyHomePageState extends State<MyHomePage> {
  late CameraController _cameraController;
  ColorViewType viewType = ColorViewType.Default;
  List<List<Color>> ListofColor = [];
  Uint8List? imageInMemory;
  bool processingData = false;
  img.Image? image;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.low);
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return processingData
        ? Scaffold(
            body: Center(
                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("% $progressMadevalue")
            ],
          )))
        : Scaffold(
            appBar: AppBar(actions: [
              SafeArea(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Quality: ${_cameraController.resolutionPreset.name} / ViewType: ${viewType.name} View"),
                ),
              )
            ]),
            drawer: Drawer(
                child: SafeArea(
              child: Column(
                children: [..._DrawerItems(context)],
              ),
            )),
            body: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Center(
                    child: Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .85,
                        width: MediaQuery.of(context).size.width,
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
                      Positioned(
                        bottom: MediaQuery.of(context).size.width * .000001,
                        left: MediaQuery.of(context).size.width * .35,
                        child: MaterialButton(
                          onPressed: () async {
                            try {
                              setState(() {
                                progressMadevalue = 0;
                                processingData = true;
                              });
                              Image? picture;
                              await _cameraController
                                  .takePicture()
                                  .then((value) async {
                                image =
                                    img.decodeImage(await value.readAsBytes());
                                picture =
                                    Image.memory(await value.readAsBytes());
                              });
                              for (var i = 0; i < image!.height; i++) {
                                ImageAnPixelHeight temp =
                                    new ImageAnPixelHeight(i, image!);

                                ListofColor.add(
                                    await compute(_imagePixelProcessing, temp));
                                progressMadevalue =
                                    ((i / image!.height * 100).toInt() & 0x7f)
                                        .toDouble();
                                setState(() {});
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowWhereOnImage(
                                            thePicture: picture!,
                                            ListOfColor: ListofColor,
                                            TypeOfColorViews: viewType,
                                            theImage: image!,
                                          )));
                              setState(() {
                                processingData = false;
                              });
                            } catch (e) {
                              log(e.toString());
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
                            child: const Center(
                              child: Text(
                                "Take Picture",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )
                ])));
  }

  List<Widget> _DrawerItems(BuildContext context) {
    List<Widget> drawerItems = [];
    List<Widget> _resolutionDropdown = [];
    for (var item in ResolutionPreset.values) {
      _resolutionDropdown.add(MaterialButton(
          child: Container(
              height: MediaQuery.of(context).size.height * .04,
              color: Colors.white,
              child: Center(
                  child: Text("${item.name}",
                      style: const TextStyle(color: Colors.black)))),
          onPressed: () => setState(() {
                _cameraController = CameraController(widget.camera, item);
              })));
    }
    drawerItems.add(ExpansionTile(
      title: const Text("Resolution Quailty"),
      children: [..._resolutionDropdown],
    ));
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
                    viewType = item;
                  })),
      ],
    ));

    return drawerItems;
  }
}

class ImageAnPixelHeight {
  int height;
  img.Image image;
  ImageAnPixelHeight(this.height, this.image);
}

List<Color> _imagePixelProcessing(ImageAnPixelHeight tempImageData) {
  List<Color> listColorbuffer = [];

  for (var x = 0; x < tempImageData.image.width; x++) {
    int temp = tempImageData.image.getPixelSafe(x, tempImageData.height);
    int b = (temp >> 16) & 0xFF;
    int r = (temp & 0xFF) << 16;
    Color bcolor = Color((temp & 0xFF00FF00) | b | r);
    if (listColorbuffer.contains(bcolor) == false) {
      listColorbuffer.add(bcolor);
    }
  }

  return listColorbuffer;
}
