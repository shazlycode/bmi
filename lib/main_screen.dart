import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isMan = true;
  String? bmiResult = "";
  double? bmi = 0.0;
  String? difference = "";
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  double differenceValue = 0.0;
  calculateBMI() {
    if (heightController.text.isEmpty || weightController.text.isEmpty) {
      return;
    }
    double heightInMeters = double.parse(heightController.text) / 100;
    double weightInKilograms = double.parse(weightController.text);
    final double bmiValue = weightInKilograms / pow(heightInMeters, 2);
    if (bmiValue > 24.9) {
      differenceValue = 24.9 * pow(heightInMeters, 2);
    } else {
      differenceValue = 18.5 * pow(heightInMeters, 2);
    }
    print(bmiValue);
    setState(() {
      bmi = bmiValue;
      // print(bmi);
      if (bmi! <= 15.9) {
        bmiResult = "Very Severly UnderWeight";
        difference = (weightInKilograms - differenceValue).toStringAsFixed(2);
      } else if (bmi! >= 16 && bmi! <= 16.9) {
        bmiResult = "Severly UnderWeight";
        difference = (weightInKilograms - differenceValue).toStringAsFixed(2);
      } else if (bmi! >= 17 && bmi! <= 18.4) {
        bmiResult = "UnderWeight";
        difference = (weightInKilograms - differenceValue).toStringAsFixed(2);
      } else if (bmi! >= 18.5 && bmi! <= 24.9) {
        bmiResult = "Normal";
        difference = "Ok 👌";
      } else if (bmi! >= 25 && bmi! <= 29.9) {
        bmiResult = "Overweight";
        difference = (weightInKilograms - differenceValue).toStringAsFixed(2);
      } else if (bmi! >= 30 && bmi! <= 34.9) {
        bmiResult = "Obese Class I";
        difference = (weightInKilograms - differenceValue).toStringAsFixed(2);
      } else if (bmi! >= 35 && bmi! <= 39.9) {
        bmiResult = "Obese Class II";
        difference = (weightInKilograms - differenceValue).toStringAsFixed(2);
      } else {
        bmiResult = "Obese Class III";
        difference = (weightInKilograms - differenceValue).toStringAsFixed(2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  heightController.clear();
                  weightController.clear();
                  bmi = 0.0;
                  bmiResult = "";
                  difference = "";
                });
              },
              icon: const Icon(Icons.clear))
        ],
        title: const Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * .25,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * .25,
                    height: size.height * .25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Age"),
                        TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style:
                              const TextStyle(decoration: TextDecoration.none),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Divider(
                            color: Color.fromARGB(255, 83, 81, 81),
                            thickness: 1,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isMan = true;
                                });
                              },
                              child: Icon(
                                Icons.man,
                                color: isMan ? Colors.blue : Colors.white,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 3,
                              color: Colors.grey[900],
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isMan = false;
                                });
                              },
                              child: Icon(
                                Icons.woman,
                                color: isMan ? Colors.white : Colors.blue,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * .5,
                    height: size.height * .25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Height"),
                        TextFormField(
                          controller: heightController,
                          onChanged: (_) {
                            if (weightController.text.isEmpty) {
                              return;
                            }
                            calculateBMI();
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style:
                              const TextStyle(decoration: TextDecoration.none),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Divider(
                            color: Color.fromARGB(255, 83, 81, 81),
                            thickness: 1,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text("Weight"),
                        TextFormField(
                          controller: weightController,
                          onChanged: (_) {
                            calculateBMI();
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(decoration: TextDecoration.none),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Divider(
                            color: Color.fromARGB(255, 83, 81, 81),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * .25,
                    height: size.height * .25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("cm"),
                        const Text("kg"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .35,
              width: size.height * .35,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    showLabels: false,
                    showAxisLine: false,
                    showTicks: false,
                    labelsPosition: ElementsPosition.inside,
                    minimum: 10,
                    maximum: 40,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 10,
                          endValue: 18.5,
                          color: Color.fromARGB(255, 39, 169, 234),
                          label: 'Underweight',
                          sizeUnit: GaugeSizeUnit.factor,
                          labelStyle:
                              GaugeTextStyle(fontFamily: 'Times', fontSize: 18),
                          startWidth: 0.30,
                          endWidth: 0.30),
                      GaugeRange(
                        startValue: 18.5,
                        endValue: 25.0,
                        color: Color.fromARGB(255, 9, 157, 46),
                        label: 'Normal',
                        labelStyle:
                            GaugeTextStyle(fontFamily: 'Times', fontSize: 20),
                        startWidth: 0.30,
                        endWidth: 0.30,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: 25.0,
                        endValue: 40,
                        color: Color.fromARGB(255, 238, 39, 39),
                        label: 'Overweight',
                        labelStyle:
                            GaugeTextStyle(fontFamily: 'Times', fontSize: 20),
                        sizeUnit: GaugeSizeUnit.factor,
                        startWidth: 0.30,
                        endWidth: 0.30,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        markerHeight: 50,
                        markerWidth: 20,
                        value: bmi!,
                      ),
                    ],
                    canScaleToFit: true,
                  )
                ],
              ),
            ),
            Text(
              "BMI= ${bmi!.toStringAsFixed(2)}",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * .10, right: size.width * .1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Category'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(bmiResult!),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Difference'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${difference!} kg",
                          style: TextStyle(
                              color: difference == "Ok"
                                  ? Colors.green
                                  : Colors.blue),
                        ),
                      ]),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Divider(thickness: 2),
            ),
            BMIMarker(
                isExactResult: bmiResult == "Very Severly UnderWeight",
                result: "Very Severly UnderWeight",
                range: "<=15.9"),
            BMIMarker(
                isExactResult: bmiResult == "Severly UnderWeight",
                result: "Severly UnderWeight",
                range: "16 - 16.9"),
            BMIMarker(
                isExactResult: bmiResult == "UnderWeight",
                result: "UnderWeight",
                range: "17 - 18.4"),
            BMIMarker(
                isExactResult: bmiResult == "Normal",
                result: "Normal",
                range: "18.5 - 24.9"),
            BMIMarker(
                isExactResult: bmiResult == "Overweight",
                result: "Overweight",
                range: "25 - 29.9"),
            BMIMarker(
                isExactResult: bmiResult == "Obese Class I",
                result: "Obese Class I",
                range: "30 - 34.9"),
            BMIMarker(
                isExactResult: bmiResult == "Obese Class II",
                result: "Obese Class II",
                range: "35 -39.9"),
            BMIMarker(
                isExactResult: bmiResult == "Obese Class III",
                result: "Obese Class III",
                range: "\>=40"),
          ],
        ),
      ),
    );
  }
}

class BMIMarker extends StatelessWidget {
  const BMIMarker({
    super.key,
    this.result,
    this.range,
    this.isExactResult = false,
  });

  final String? result;
  final String? range;
  final bool? isExactResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Row(
        children: [
          if (isExactResult!) Icon(Icons.arrow_right, color: Colors.blue),
          Text(
            result!,
            style:
                TextStyle(color: isExactResult! ? Colors.blue : Colors.white),
          ),
          Spacer(),
          Text(
            range!,
            style:
                TextStyle(color: isExactResult! ? Colors.blue : Colors.white),
          ),
        ],
      ),
    );
  }
}


//  Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Flexible(
//                     flex: 1,
//                     child: Container(
//                       width: 50,
//                       child: Column(
//                         children: [
                         
//                         ],
//                       ),
//                     )),
//                 Flexible(
//                     flex: 2,
//                     child: Column(
//                       children: [
//                         const Text("Height"),
//                         Container(
//                           width: 50,
//                           child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             style: TextStyle(decoration: TextDecoration.none),
//                             decoration:
//                                 InputDecoration(border: InputBorder.none),
//                           ),
//                         ),
//                         Divider(
//                           color: Color.fromARGB(255, 83, 81, 81),
//                           thickness: 1,
//                         )
//                       ],
//                     )),
//                 Flexible(
//                   flex: 1,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("cm"),
//                       const Text("kg"),
//                     ],
//                   ),
//                 )
//               ],
//             ),
           