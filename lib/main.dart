import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  //Button Widget
  Widget calcbutton(String btntxt, Color? btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: btncolor,
        padding: const EdgeInsets.all(10),
      ),
      child: Text(
        btntxt,
        style: TextStyle(
          fontSize: 35,
          color: txtcolor,
        ),
      ),
    );
  }

  Widget takeImageButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.amber[700],
        padding: const EdgeInsets.all(10),
      ),
      child: IconButton(
        onPressed: () {
          _cameraImage();
        },
        icon: const Icon(
          Icons.camera_alt,
          size: 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Calculator display
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                    left: 3,
                    right: 3,
                  ),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            calcbutton('AC', Colors.amber[700], Colors.white),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                controller:
                                    TextEditingController(text: textToshow),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    calcbutton('7', Colors.grey, Colors.black),
                    calcbutton('8', Colors.grey, Colors.black),
                    calcbutton('9', Colors.grey, Colors.black),
                    calcbutton('/', Colors.amber[700], Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    calcbutton('4', Colors.grey[850], Colors.white),
                    calcbutton('5', Colors.grey[850], Colors.white),
                    calcbutton('6', Colors.grey[850], Colors.white),
                    calcbutton('x', Colors.amber[700], Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    calcbutton('1', Colors.grey[850], Colors.white),
                    calcbutton('2', Colors.grey[850], Colors.white),
                    calcbutton('3', Colors.grey[850], Colors.white),
                    calcbutton('-', Colors.amber[700], Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    calcbutton('0', Colors.grey[850], Colors.white),
                    calcbutton('.', Colors.grey[850], Colors.white),
                    calcbutton('=', Colors.amber[700], Colors.white),
                    calcbutton('+', Colors.amber[700], Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      calcbutton('X', Colors.grey[850], Colors.white),
                      calcbutton('Y', Colors.grey[850], Colors.white),
                      calcbutton('Z', Colors.amber[700], Colors.white),
                      takeImageButton(),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _pickImage();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minimumSize: const Size(double.infinity, 110),
                  ),
                  icon: const Icon(
                    Icons.upload,
                    size: 30,
                  ),
                  label: const Text(
                    'Upload',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                        width: 110,
                        height: 60,
                      )
                    : Image.asset(
                        'lib/assets/logo.png',
                        fit: BoxFit.cover,
                        width: 110,
                        height: 60,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Calculator logic
  dynamic textToshow = '0';

  void calculation(btnText) {
    if (btnText == 'AC') {
      textToshow = '';
    } else if (btnText == '=') {
      //do the calcul
    } else {
      textToshow += btnText;
    }

    setState(() {});
  }

  File? _image;

  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      _pickedFile = pickedImage;
      await _cropImage();
    }
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
          _image = File(_croppedFile!.path);
        });
      }
    }
  }

  Future<void> _cameraImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      _pickedFile = pickedImage;
      await _cropImage();
    }
  }
}
