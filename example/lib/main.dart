import 'package:flutter/material.dart';
import 'package:safe_scale/safe_scale.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeScale: Test Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'SafeScale: Test Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // controls the value of the outer black box and values of inner container/circle are dependent on it
  double sliderValue = 1.0;
  // dimensions of black screen
  late double tempHeight;
  late double tempWidth;

  @override
  Widget build(BuildContext context) {
    SafeScale().init(context, MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width);

    // pick up the dimensions of the device for the sake of example project
    tempHeight =
        SafeScale.getMyDynamicHeight(MediaQuery.of(context).size.height) *
            0.1 *
            (sliderValue);
    tempWidth =
        SafeScale.getMyDynamicWidth(MediaQuery.of(context).size.width) *
            0.1 *
            (sliderValue);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                height: SafeScale.screenHeight * 0.8,
              ),
              Container(
                height: tempHeight,
                width: tempWidth,
                color: Colors.black38,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: SafeScale.getMyDynamicWidth(20),
                    vertical: SafeScale.getMyDynamicHeight(20),
                  ),
                  color: Colors.blue.shade400,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: SafeScale.getMyDynamicWidth(30),
                      vertical: SafeScale.getMyDynamicHeight(30),
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
              ),
            ],
          ),
          Slider.adaptive(
              value: sliderValue,
              label: sliderValue.toString(),
              min: 1,
              max: 7,
              onChanged: (newValue) => setState(() => sliderValue = newValue)),
        ],
      )),
    );
  }
}
