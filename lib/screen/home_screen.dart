import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File _image;
  late List _results;
  bool imageSelect = false;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/weapon_classification.tflite",
        labels: "assets/labels.txt"))!;
    // ignore: avoid_print
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            'Welcome to Klasifikasi',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Senjata Tradisional',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Jawa Barat',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Masukkan gambar senjata tradisional',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'Jawa Barat untuk diklasifikasi.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          (imageSelect)
              ? Container(
                  margin: const EdgeInsets.all(0),
                  child: Image.file(_image),
                )
              : Container(
                  margin: const EdgeInsets.all(120),
                  child: const Opacity(
                    opacity: 0.8,
                    child: Center(
                      child: Text("No image selected"),
                    ),
                  ),
                ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect)
                  ? _results.map((result) {
                      return Card(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF2465ac),
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    }).toList()
                  : [],
            ),
          )
        ],
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2465ac),
        ),
        onPressed: pickImage,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo),
            SizedBox(width: 10),
            Text('Pick Image'),
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}
