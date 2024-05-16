import 'package:client/model/data_type.dart';
import 'package:client/screens/result_screen.dart';
import 'package:client/widgets/function_form.dart';
import 'package:flutter/material.dart';
import 'controllers/download_func.dart';
import 'controllers/upload_func.dart';
import 'widgets/function_form.dart';

const String HOST = '192.168.1.24';
const int PORT = 1234;
const String serverUrl = 'http://$HOST:$PORT';

List<DropdownMenuItem<String>> servers = [
  const DropdownMenuItem(
    value: HOST,
    child: Text('Shrey'),
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
  

  int dataSize(List<DataType> dataTypes){
    for (int i = 0; i < dataTypes.length; i++) {
      if (dataTypes[i].isSelected) {
        return dataTypes[i].value;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 255, 1),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(238, 238, 255, 1),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home),
              iconSize: 30,
              color: const Color.fromRGBO(0, 10, 255, 1),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.history),
              iconSize: 30,
              color: const Color.fromRGBO(0, 10, 255, 1),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              iconSize: 30,
              color: const Color.fromRGBO(0, 10, 255, 1),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
              iconSize: 30,
              color: const Color.fromRGBO(0, 10, 255, 1),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5.0,
                        blurRadius: 7.0,
                        offset: const Offset(0.0, 4.0),
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
            Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 1),
                  child: Container(
                    width: 450,
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color(0xFF000AFF),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(200),
                        topRight: Radius.circular(200),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-0.04, 0.42),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: MaterialButton(
                          child: const Icon(
                            Icons.power_settings_new,
                            color: Color(0xFF000AFF),
                            size: 100,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  function: isSelected[0] ? 'Download' : 'Upload',
                                  dataSize: dataSize(dataTypes),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
