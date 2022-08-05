import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mysql/main.dart';

class FormInfo extends StatefulWidget {
  const FormInfo({Key? key}) : super(key: key);

  @override
  State<FormInfo> createState() => _FormInfoState();
}

class _FormInfoState extends State<FormInfo> {
  final _formState = GlobalKey<FormState>();

  // TextEditingController _controller = TextEditingController();
  //  @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   _controller.dispose();
  //   super.dispose();
  // }

  DateTime? _pickedDate;
  String? _trainNo;

  onSearch() {
    _formState.currentState?.save();
    // ignore: avoid_print
    print(_pickedDate);
    // ignore: avoid_print
    print(_trainNo);
    int flag = 0;
    for (int i = 0; i < listOftrain.length; i++) {
      if (_trainNo == listOftrain[i].id) {
        print(listOftrain[i].name);
        int n = _pickedDate!.weekday;
        int weekday = int.parse(listOftrain[i].workingDays);
        int power = int.parse(pow(2, n - 1).toString());
        if ((weekday & power) > 0) {
          print("available");
          for (int j = 0; j < listOfSchedule.length; j++) {
            if (listOfSchedule[j].TrainID == _trainNo) {
              var stationId = listOfSchedule[j].StationID;
              for (int k = 0; k < listOfStation.length; k++) {
                if (listOfStation[k].id == stationId) {
                  var arrivalTime = listOfSchedule[j].ArrivalTime;
                  var departureTime = listOfSchedule[j].DepartureTime;

                  print("station name : " + listOfStation[k].name);
                  if (arrivalTime != null) {
                    print(" ETA: " + arrivalTime);
                  }
                  if (departureTime != null) {
                    print(" ETD: " + departureTime);
                  }
                }
              }
            }
          }
        } else {
          print("Unavailable");
        }
        flag = 1;

        break;
        // print(_pickedDate!.weekday);

      }
    }
    if (flag == 0) {
      print("train not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formState,
          child: TextFormField(
            onSaved: ((newValue) {
              setState(() {
                _trainNo = newValue!;
              });
            }),
            decoration: const InputDecoration(
              labelText: "Train Number",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () async {
                setState(() async {
                  _pickedDate = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 2)),
                    lastDate: DateTime.now().add(const Duration(days: 2)),
                  ))!;
                });
              },
              icon: const Icon(Icons.calendar_today),
            ),
            const Text('Select Date'),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: onSearch,
              icon: const Icon(Icons.search),
              label: const Text("Search"),
            ),
          ],
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Train No: $_trainNo ",
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Date: $_pickedDate",
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
