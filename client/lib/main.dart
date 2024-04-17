import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String HOST = '192.168.1.21';
const int PORT = 1234;
const String serverUrl = 'http://$HOST:$PORT';

void main() {
  runApp(const SpeedTestApp());
}

class SpeedTestApp extends StatelessWidget {
  const SpeedTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Speed Test',
      home: SpeedTestPage(),
    );
  }
}

double calculateSpeed(double length, DateTime startTime, DateTime endTime) {
  final int duration = endTime.difference(startTime).inSeconds;
  final double speed = (length / duration);
  return speed;
}

Future<double> downloadTest() async {
  const double expectedLength = 1000000; // 1 MB in bits
  final url = Uri.parse('$serverUrl/download');
  final DateTime startTime = DateTime.now();
  final response = await http.get(url);
  final DateTime endTime = DateTime.now();
  
  // Calculate the time difference in milliseconds
  final timeDifference = endTime.difference(startTime).inMilliseconds;

  // Ensure that the time difference is not zero to avoid division by zero
  final downloadSpeed = timeDifference > 0 ? (expectedLength / timeDifference) : 0;

  print('Download Speed: $downloadSpeed bits per millisecond');
  return 0;
}


class SpeedTestPage extends StatefulWidget {
  const SpeedTestPage({super.key});

  @override
  _SpeedTestPageState createState() => _SpeedTestPageState();
}

class _SpeedTestPageState extends State<SpeedTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speed Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ElevatedButton(
              onPressed: downloadTest,
              child: Text('Start Download Test'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Implementing....',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start Upload Test'),
            ),
            const SizedBox(height: 20),
            const Text(
              'IMPLEMENTING....',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
