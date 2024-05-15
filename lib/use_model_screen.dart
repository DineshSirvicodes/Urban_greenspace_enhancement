import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UseModelSelectionScreen extends StatefulWidget {
  const UseModelSelectionScreen({super.key, required this.modelName});

  final String modelName;

  @override
  State<UseModelSelectionScreen> createState() =>
      _UseModelSelectionScreenState();
}

class _UseModelSelectionScreenState extends State<UseModelSelectionScreen> {
  bool outputReceived = false;
  bool reqSent = false;
  String? predictedImageUrl;
  Image? predictedImage;
  String? base64Image;

  postData() async {
    setState(() {
      reqSent = true;
    });
    showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 0.0,
            backgroundColor: Colors.white.withOpacity(0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://segmentation-model.onrender.com/upload-image/?files'));
    request.files.add(await http.MultipartFile.fromPath('files', _image!.path));
    request.headers["ngrok-skip-browser-warning"]="69420";
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var parsedData = jsonDecode(data);
      base64Image = parsedData["output"];
      log(parsedData["output"]);

      predictedImage = Image.memory(
        base64Decode(((parsedData["output"]))),
        fit: BoxFit.fitWidth,
      );
    } else {
      Fluttertoast.showToast(
          msg: "${response.statusCode} Error: ${response.reasonPhrase}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    Navigator.pop(context);
    setState(() {
      reqSent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "${widget.modelName}",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          backgroundColor: Color(0xff0e884d),
        ),
        backgroundColor: Color(0xbd4dda8d),
        body: Center(
          child: (predictedImage == null)
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_image == null)
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Image",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "MadimiOne"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  _pickImage();
                                },
                                child: Text("Select Image",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: "MadimiOne")),
                              ),
                            ],
                          ),
                        ),
                      if (_image != null)
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15)),
                            child: Image.file(
                              _image!,
                            ),
                          ),
                        ),
                      if (!reqSent)
                        ElevatedButton(
                            onPressed: () {
                              if (_image != null) {
                                postData();
                              }
                            },
                            child: Text("Start Classification")),
                      if (reqSent && !outputReceived)
                        ElevatedButton(
                            onPressed: () {},
                            child: Text(
                                "Please Wait While We Process your request!!")),
                      if (outputReceived && reqSent)
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "MadimiOne"),
                              ),
                              Text("(SATELLITE IMAGE)",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: "MadimiOne")),
                            ],
                          ),
                        ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.memory(
                            base64Decode(base64Image!),
                            fit: BoxFit.fitWidth
                            ,
                          ),
                        ),
                      ),
                      if (predictedImage != null)
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                predictedImage = null;
                                _image = null;
                              });
                            },
                            child: Text(
                                "Want to Classification Something Else??")),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  File? _image;

  _pickImage() async {
    final picker = ImagePicker.platform;
    _image = null;
    var fileselected = await (picker.getImage(source: ImageSource.gallery));
    if (fileselected != null) {
      setState(() {
        _image = File((fileselected.path));
      });
    }
    if (_image != null) {
      // makeRequest1(); '
      log("image uploaded");
      // loadingWidget(context);
    }
  }
}
