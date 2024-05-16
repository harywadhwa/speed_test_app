import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../controllers/download_func.dart';
import '../controllers/upload_func.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {super.key, this.function = "Download", this.dataSize = 10});
  final String function;
  final int dataSize;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  
  double downloadSpeed = 0.0;
  double uploadSpeed = 0.0;

  void startDownloadTest(int data) {
    double totalDownloadSpeed = 0.0;
    for (int i = 0; i < 1; i++) {
      downloadTest(data).then((value) {
        //new method
        setState(() {
          downloadSpeed = value;
        });
        totalDownloadSpeed += value;
      });
    }
    setState(() {
      downloadSpeed = totalDownloadSpeed / 1; // Calculate average speed
    });
  }

  void startUploadTest(int data) {
    double totalUploadSpeed = 0.0;
    for (int i = 0; i < 1; i++) {
      uploadTest(data).then((value) {
        //new method
        setState(() {
          uploadSpeed = value;
        });
        totalUploadSpeed += value;
      });
    }
    setState(() {
      uploadSpeed = totalUploadSpeed / 1; // Calculate average speed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 255, 1),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(238, 238, 255, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.function),
            const SizedBox(height: 20),
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 200,
                      endValue: 1000,
                      color: Colors.green,
                      startWidth: 10,
                      endWidth: 10)
                ], pointers: <GaugePointer>[
                  NeedlePointer(
                    value: widget.function == "Download"
                        ? downloadSpeed
                        : uploadSpeed,
                  )
                ], annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Container(
                          child: Text( widget.function == "Download" ? '${downloadSpeed} bps' : "${uploadSpeed} bps",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold))),
                      angle: 90,
                      positionFactor: 0.8)
                ])
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.function == "Download") {
                  startDownloadTest(widget.dataSize);
                } else {
                  startUploadTest(widget.dataSize);
                }
              },
              child: const Text("Start Test!"),
            ),
          ],
        ),
      ),
    );
  }
}
