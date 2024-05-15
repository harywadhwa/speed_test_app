import 'dart:io';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getFile(int data) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  File file = File('${appDocDir.path}/testfile.txt');
  await file.writeAsString('0' * (data * 1000000)); // Write a 100 MB file
  return file;
}


Future<double> uploadTest(int data) async {
  final double expectedLength = data * 1000000; // 1 MB in bits
  final url = Uri.parse('$serverUrl/upload');
  final DateTime startTime = DateTime.now();

  // Get a file from device storage to simulate uploading
  File file = await getFile(data);

  // Create a multipart request
  var request = http.MultipartRequest('POST', url);

  // Add the file to be uploaded
  request.files.add(await http.MultipartFile.fromPath('file', file.path));

  // Send the request
  var response = await request.send();

  // Get the response
  await response.stream.drain();

  final DateTime endTime = DateTime.now();

  // Calculate the time difference in milliseconds
  final timeDifference = endTime.difference(startTime).inMilliseconds;

  // Ensure that the time difference is not zero to avoid division by zero
  final double uploadSpeed =
      timeDifference > 0 ? (expectedLength / timeDifference) : 0;

  return uploadSpeed;
}

