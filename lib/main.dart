import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  GraphState createState() => GraphState();
}

class GraphState extends State<Graph> {
  List<FlSpot> dummyData1 = [];
  List<FlSpot> dummyData2 = [];
  List<FlSpot> dummyData3 = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {  
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000'));


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var item in data['dummyData1']) {
        dummyData1.add(FlSpot(item['x'], item['y']));
      }

      for (var item in data['dummyData2']) {
        dummyData2.add(FlSpot(item['x'], item['y']));
      }

      for (var item in data['dummyData3']) {
        dummyData3.add(FlSpot(item['x'], item['y']));
      }
 
      print(response.body);
      setState(() {});
    } else {
         // ignore: avoid_print
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // An error occurred during the request
         // ignore: avoid_print
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Graphique"),
      ),
      body: Center(
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: dummyData1,
                isCurved: true,
                barWidth: 3,
                color: Colors.indigo,
              ),
              LineChartBarData(
                spots: dummyData2,
                isCurved: true,
                barWidth: 3,
                color: Colors.red,
              ),
              LineChartBarData(
                spots: dummyData3,
                isCurved: false,
                barWidth: 3,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bonjour"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bienvenue sur l'appli",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const Text("Clique en dessous pour afficher le graph"),
            const Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Graph(),
                  ),
                );
              },
              child: const Text(
                "Afficher le graph",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
