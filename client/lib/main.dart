import 'package:client/widgets/function_form.dart';
import 'package:flutter/material.dart';
import 'controllers/download_func.dart';
import 'controllers/upload_func.dart';

const String HOST = '192.168.1.7';
const int PORT = 1234;
const String serverUrl = 'http://$HOST:$PORT';

List<DropdownMenuItem<String>> servers = [
  DropdownMenuItem(
    child: Text('Shrey'),
    value: HOST,
  )
];

List<DropdownMenuItem<int>> dataSizes = [
  DropdownMenuItem(
    child: Text('25Mb'),
    value: 25,
  ),
  DropdownMenuItem(
    child: Text('15Mb'),
    value: 15,
  ),
  DropdownMenuItem(
    child: Text('10Mb'),
    value: 10,
  ),
  DropdownMenuItem(
    child: Text('5Mb'),
    value: 5,
  )
];

void main() {
  runApp(const SpeedTestApp());
}

class SpeedTestApp extends StatelessWidget {
  const SpeedTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Speed Test',
      home: SpeedTestPage(),
    );
  }
}

class SpeedTestPage extends StatefulWidget {
  const SpeedTestPage({Key? key}) : super(key: key);

  @override
  _SpeedTestPageState createState() => _SpeedTestPageState();
}

class _SpeedTestPageState extends State<SpeedTestPage> {
  double downloadSpeed = 0.0;
  double uploadSpeed = 0.0;

  void startDownloadTest() {
    double totalDownloadSpeed = 0.0;
    for (int i = 0; i < 10; i++) {
      downloadTest().then((value) {
        totalDownloadSpeed += value;
        setState(() {
          downloadSpeed = totalDownloadSpeed / 10; // Calculate average speed
        });
      });
    }
  }

  void startUploadTest() {
    double totalUploadSpeed = 0.0;
    for (int i = 0; i < 10; i++) {
      uploadTest().then((value) {
        totalUploadSpeed += value;
        setState(() {
          uploadSpeed = totalUploadSpeed / 10; // Calculate average speed
        });
      });
    }
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
          children: [
            Container(
              width: 330,
              height: 53,
              margin: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5.0, // Adjusts how far the shadow spreads
                    blurRadius: 7.0, // Adjusts the blur amount of the shadow
                    offset: const Offset(0.0, 4.0), // Adjusts the shadow's offset
                  ),
                ],
              ),
              child: DropdownButton<String>(
                padding: const EdgeInsets.all(15),
                value: servers[0].value,
                onChanged: (value) {},
                items: servers,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 24,
                ),
                underline: Container(),
                isExpanded: true,
              ),
            ),
            const SizedBox(height: 40),
            const FunctionForm(),
          ],
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Speed Test'),
  //       centerTitle: true,
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           ElevatedButton(
  //             onPressed: startDownloadTest,
  //             child: const Text('Start Download Test'),
  //           ),
  //           const SizedBox(height: 20),
  //           Text(
  //             'Download: ${downloadSpeed.toStringAsFixed(2)} bits per second',
  //           ),
  //           const SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: startUploadTest,
  //             child: const Text('Start Upload Test'),
  //           ),
  //           const SizedBox(height: 20),
  //           Text(
  //             'Upload: ${uploadSpeed.toStringAsFixed(2)} bits per second',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
// MaterialButton(
//                 onPressed: () {
//                   print('Button pressed ...');
//                 },
//                 color: Colors.white,
//                 elevation: 3,
//                 shape: CircleBorder(),
//                 padding: EdgeInsets.all(30),
//                 child: Icon(
//                   Icons.power_settings_new,
//                   color: Color(0xFF000AFF),
//                   size: 100,
//                 ),
//               ),