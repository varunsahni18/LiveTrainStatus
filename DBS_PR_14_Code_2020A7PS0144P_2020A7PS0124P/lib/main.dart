import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:mysql/Model.dart';
import 'package:mysql/ScheduleModel.dart';
import 'package:mysql/StationModel.dart';
import 'package:mysql/adminCenter.dart';
import 'package:mysql/availableTrain.dart';
import 'package:mysql/trainStatus.dart';

void main() {
  runApp(const MyApp());
}

var listOftrain = <Model>[];
var listOfStation = <StationModel>[];
var listOfSchedule = <ScheduleModel>[];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Live Status DBMS Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Train Live Status'),
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
  DateTime? _pickedDate;
  String? _trainNo;

  onSearch() {
    // ignore: avoid_print
    print(_pickedDate);
    // ignore: avoid_print
    print(_trainNo);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Card(
                color: const Color.fromARGB(255, 182, 218, 247),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: const Text(
                          "Train Status",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 6, 75, 131),
                          ),
                        ),
                        subtitle: const Text(
                            "To check Train Detail(Name, status, route)"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TrainStatus()),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Card(
                color: const Color.fromARGB(255, 182, 218, 247),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: const Text(
                          "Available Trains",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 6, 75, 131),
                          ),
                        ),
                        subtitle: const Text(
                            "To check Train Available between source and destination"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AvailableTrain()),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Card(
                color: const Color.fromARGB(255, 182, 218, 247),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: const Text(
                          "Admin Center",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 6, 75, 131),
                          ),
                        ),
                        subtitle: const Text("Access the Admin privileges"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminCenter()),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/////////////////////////////////////////////////////Train Data////////////////////////////////////////
  Future getData() async {
    var url = Uri.https('feracious-feedback.000webhostapp.com', '/getTrain.php',
        {'q': '{https}'});
    http.Response response = await http.get(url);
    // print('response is: ' + response.body);
    // var data = jsonDecode(response.body);
    // print('data printed is: ' + data[0][0]);
    // var listOfModel = <Model>[];
    // for (var item in data) {
    //   var model = Model(item.ID, item.NAME, item.WorkingDays);
    //   listOfModel.add(model);
    // }

    // print('The list of model is: ' + listOfModel.toString());

    var allDataTrain = json.decode(response.body);

    for (var data in allDataTrain) {
      var model = Model(data['ID'], data['Name'], data['WorkingDays']);
      listOftrain.add(model);
    }
    // print(listOftrain[0].id);
    // for (var i = 0; i < listOftrain.length; i++) {
    //   print(listOftrain[i].id);
    //   print(listOftrain[i].name);
    //   print(listOftrain[i].workingDays);
    // }

    /////////////////////////////////////////////////////Station Data////////////////////////////////////////
    var url2 = Uri.https('feracious-feedback.000webhostapp.com',
        '/getStation.php', {'q': '{https}'});

    http.Response response2 = await http.get(url2);

    var allDataStation = jsonDecode(response2.body);

    for (var data in allDataStation) {
      var stationModel = StationModel(data['ID'], data['Name'], data['City']);
      listOfStation.add(stationModel);
    }
    // print(listOfStation[0].id);

    /////////////////////////////////////////////////////Schedule Data////////////////////////////////////////
    var url3 = Uri.https('feracious-feedback.000webhostapp.com',
        '/getSchedule.php', {'q': '{https}'});

    http.Response response3 = await http.get(url3);
    var allDataSchedule = jsonDecode(response3.body);

    for (var data in allDataSchedule) {
      var scheduleModel = ScheduleModel(
          data['ArrivalTime'],
          data['DepartureTime'],
          data['Distance'],
          data['StationID'],
          data['NextStationID'],
          data['TrainID']);
      listOfSchedule.add(scheduleModel);
    }
    // print(listOfSchedule[1].ArrivalTime);
  }
}
