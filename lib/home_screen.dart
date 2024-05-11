import 'package:flutter/material.dart';
import 'package:urban_green_space_enhancement/about_us_screen.dart';
import 'package:urban_green_space_enhancement/login_screen.dart';
import 'package:urban_green_space_enhancement/model_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var textStyle = TextStyle(fontSize: 20, color: Colors.white,
      fontFamily: "MadimiOne");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
                image: AssetImage("assets/background1.jpeg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "HOME",
                        style: textStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return AboutUsScreen();
                            }));
                      },
                      child: Text(
                        "ABOUT",
                        style: textStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "CONTACT",
                        style: textStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                      },
                      child: Text(
                        "LOGIN",
                        style: textStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    scale: 3,
                  ),
                  Text(
                    "ENHANCE YOUR URBAN\nGREEN SPACE",
                    style: textStyle.copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ModelSelectionScreen();
                      }));
                    },
                    child: Text("TRY NOW",style: TextStyle(
                    fontFamily: "MadimiOne"),),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/instagram.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/facebook.png",
                    height: 50,
                    fit: BoxFit.cover,
                    width: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/X-Logo.png",
                          fit: BoxFit.cover, height: 25, width: 25),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
