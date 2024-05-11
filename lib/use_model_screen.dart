import 'package:flutter/material.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
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
                        onPressed: () {},
                        child: Text("Select Image",
                            style: TextStyle(
                                fontSize: 20, fontFamily: "MadimiOne")),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              if (!reqSent)
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        reqSent=true;
                      });
                    }, child: Text("Start Classification")),
              if(reqSent && !outputReceived) ElevatedButton(
                  onPressed: () {

                  }, child: Text("Please Wait While We Process your request!!")),
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
                          style:
                              TextStyle(fontSize: 20, fontFamily: "MadimiOne")),
                    ],
                  ),
                ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
