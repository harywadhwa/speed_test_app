import 'package:flutter/material.dart';
import 'controllers/download_func.dart';
import 'controllers/upload_func.dart';

const String HOST = '172.21.32.1';
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
      backgroundColor: Color(0xFFEEEEFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color(0xFF000AFF),
          automaticallyImplyLeading: false,
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Container(
              width: 434,
              height: 400,
              decoration: const BoxDecoration(
                color: Color(0xFF000AFF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(150),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  print('Button pressed ...');
                },
                color: Colors.white,
                elevation: 3,
                shape: CircleBorder(),
                padding: EdgeInsets.all(30),
                child: Icon(
                  Icons.power_settings_new,
                  color: Color(0xFF000AFF),
                  size: 100,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.05, -0.88),
              child: Container(
                padding: EdgeInsets.all(10),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFF000AFF),
                    width: 2,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: servers[0].value,
                    onChanged: (String? newValue) {},
                    items: servers,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.12, -0.65),
              child: Container(
                padding: EdgeInsets.all(10),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFF000AFF),
                    width: 2,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dataSizes[0].value.toString(),
                    onChanged: (String? newValue) {},
                    items: dataSizes.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.value.toString() + 'Mb'),
                        value: item.value.toString(),
                      );
                    }).toList(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
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
