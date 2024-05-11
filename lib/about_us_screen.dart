import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop),
                    image: AssetImage("assets/background5.png"),
                    fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                Spacer(),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0),
                    child: Text(
                      "ABOUT US",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          fontFamily: "MadimiOne"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Rapid urbanization has led to the depletion of green spaces in many cities, impacting the well-being of residents and overall environmental health. This proposes an innovative approach to enhance urban green spaces by employing a comprehensive framework that integrates land use classification, machine learning (ML) training, model deployment, and Google Cloud Platform (GCP) integration and a scalable approach for identifying, planning, and implementing green space enhancements offers a holistic solution for cities seeking to prioritize and optimize their green infrastructure in the face of increasing urbanization. The outcomes of this research contribute to the development of data-driven strategies for urban green space enhancement, fostering sustainable urban development and improving the overall quality of life for urban residents. The proposed framework serves as a valuable tool for city planners, environmentalists, and policymakers seeking innovative solutions to address the challenges associated with urbanization and its impact on green spaces.",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "MadimiOne"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 35,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
