import 'package:flutter/material.dart';
import 'package:mysql/main.dart';

class AvailableTrain extends StatefulWidget {
  const AvailableTrain({Key? key}) : super(key: key);

  @override
  State<AvailableTrain> createState() => _AvailableTrainState();
}

class _AvailableTrainState extends State<AvailableTrain> {
  final _availableState = GlobalKey<FormState>();
  final _availableState2 = GlobalKey<FormState>();

  String? _source;
  String? _destination;
  var station1, station2;

  onsearch() {
    _availableState.currentState?.save();
    _availableState2.currentState?.save();
    // for (var i = 0; i < listOfSchedule.length; i++) {
    //   if (listOfSchedule[i].ArrivalTime != null)
    //     print(listOfSchedule[i].ArrivalTime);
    //   if (listOfSchedule[i].DepartureTime != null)
    //     print(listOfSchedule[i].DepartureTime);
    //   if (listOfSchedule[i].Distance != null) print(listOfSchedule[i].Distance);
    //   if (listOfSchedule[i].StationID != null)
    //     print(listOfSchedule[i].StationID);
    //   if (listOfSchedule[i].NextStationID != null)
    //     print(listOfSchedule[i].NextStationID);
    //   if (listOfSchedule[i].TrainID != null) print(listOfSchedule[i].TrainID);
    // }
    if (_source != _destination) {
      for (int i = 0; i < listOfStation.length; i++) {
        if (_source == listOfStation[i].name) {
          station1 = listOfStation[i].id;
        }
        if (_destination == listOfStation[i].name) {
          station2 = listOfStation[i].id;
        }
      }

      for (int i = 0; i < listOftrain.length; i++) {
        var tid = listOftrain[i].id;
        var tname = listOftrain[i].name;
        for (int j = 0; j < listOfSchedule.length; j++) {
          if (listOfSchedule[j].StationID == station1 &&
              tid == listOfSchedule[j].TrainID) {
            for (int k = j; k < listOfSchedule.length; k++) {
              if (listOfSchedule[k].StationID == station2 &&
                  tid == listOfSchedule[k].TrainID) {
                print('Train ' + tname + ' ');
              }
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Trains")),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Form(
              key: _availableState,
              child: TextFormField(
                onSaved: ((newValue) {
                  setState(() {
                    _source = newValue!;
                  });
                }),
                decoration: const InputDecoration(
                  labelText: "Source",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: _availableState2,
              child: TextFormField(
                onSaved: ((newValue) {
                  setState(() {
                    _destination = newValue!;
                  });
                }),
                decoration: const InputDecoration(
                  labelText: "Destination",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                    onPressed: onsearch,
                    icon: const Icon(Icons.search),
                    label: const Text("Search"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
