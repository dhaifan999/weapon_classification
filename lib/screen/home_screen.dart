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
                  height: 300,
                  width: 300,
                  margin: const EdgeInsets.all(0),
                  child: Image.file(_image),
                )
              : Container(
                  margin: const EdgeInsets.all(120),
                  child: const Opacity(
                    opacity: 0.8,
                    child: Center(
                      child: Text(
                        "Tidak ada gambar yang dipilih",
                        textAlign: TextAlign.center,
                      ),
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
          foregroundColor: Colors.white,
        ),
        onPressed: () => showImagePickerOptions(context),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo),
            SizedBox(width: 10),
            Text('Pilih Gambar'),
          ],
        ),
      ),
    );
  }

  Future<void> showImagePickerOptions(BuildContext context) async {
    final optionsDialog = AlertDialog(
      title: const Text('Pilih Gambar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Ambil Gambar'),
            onTap: () async {
              Navigator.pop(context);
              final image =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (image != null) {
                final file = File(image.path);
                imageClassification(file);
              }
            },
          ),
          ListTile(
            title: const Text('Pilih dari Galeri'),
            onTap: () async {
              Navigator.pop(context);
              final image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                final file = File(image.path);
                imageClassification(file);
              }
            },
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (context) => optionsDialog);
  }
}
