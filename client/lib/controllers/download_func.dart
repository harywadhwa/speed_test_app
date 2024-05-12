import 'package:http/http.dart' as http;
import '../main.dart';

Future<double> downloadTest() async {
  const double expectedLength = 1000000; // 100 MB in bits
  final url = Uri.parse('$serverUrl/download');
  final DateTime startTime = DateTime.now();
  final response = await http.get(url);
  final DateTime endTime = DateTime.now();

  // Calculate the time difference in milliseconds
  final timeDifference = endTime.difference(startTime).inMilliseconds;

  // Ensure that the time difference is not zero to avoid division by zero
  final double downloadSpeed =
      timeDifference > 0 ? (expectedLength / timeDifference) : 0;
      
  return downloadSpeed;
}
