import 'package:flutter/material.dart';
import 'package:mysql/main.dart';

class AdminCenter extends StatefulWidget {
  const AdminCenter({Key? key}) : super(key: key);

  @override
  State<AdminCenter> createState() => _AdminCenterState();
}

class _AdminCenterState extends State<AdminCenter> {
  String? _TrainNo;
  String? _delay;
  final _adminState = GlobalKey<FormState>();
  final _adminState2 = GlobalKey<FormState>();

  onEnter() {
    _adminState.currentState?.save();
    _adminState2.currentState?.save();
    int delay = 0;
    if (_delay != null) {
      delay = int.parse(_delay!);
    }
    print("delay : " + delay.toString());

    for (int i = 0; i < listOfSchedule.length; i++) {
      if (listOfSchedule[i].TrainID == _TrainNo) {
        if (listOfSchedule[i].ArrivalTime != null) {
          var arrive = listOfSchedule[i].ArrivalTime;
          var arriveWithoutsemi = arrive!.replaceAll(RegExp(r'[^\w\s]+'), '');
          int arrTime = int.parse(arriveWithoutsemi);
          arrTime = arrTime ~/ 100;
          int min1 = arrTime % 100;
          arrTime = arrTime ~/ 100;
          int hr1 = arrTime;
          min1 = min1 + delay;
          int addhr = min1 ~/ 60;
          hr1 = hr1 + addhr;
          hr1 = hr1 % 24;
          min1 = min1 % 60;
          var hr1str = hr1.toString();
          var min1str = min1.toString();
          if (min1 < 10) {
            min1str = '0' + min1str;
          }
          var strArrTime = hr1str + ':' + min1str + ':00';
          print('Arrival Time at Station No. ' +
              listOfSchedule[i].StationID +
              ' is ' +
              strArrTime);
        }
        if (listOfSchedule[i].DepartureTime != null) {
          var leave = listOfSchedule[i].DepartureTime;
          var leaveWithoutsemi = leave!.replaceAll(RegExp(r'[^\w\s]+'), '');
          int leaveTime = int.parse(leaveWithoutsemi);
          leaveTime = leaveTime ~/ 100;
          int min1 = leaveTime % 100;
          leaveTime = leaveTime ~/ 100;
          int hr1 = leaveTime;
          min1 = min1 + delay;
          int addhr = min1 ~/ 60;
          hr1 = hr1 + addhr;
          hr1 = hr1 % 24;
          min1 = min1 % 60;
          var hr1str = hr1.toString();
          var min1str = min1.toString();
          if (min1 < 10) {
            min1str = '0' + min1str;
          }
          var strleaveTime = hr1str + ':' + min1str + ':00';
          print('Departure Time at Station No. ' +
              listOfSchedule[i].StationID +
              ' is ' +
              strleaveTime);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Center")),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Admin Center",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 25,
            ),
            Form(
              key: _adminState,
              child: TextFormField(
                onSaved: ((newValue) {
                  setState(() {
                    _TrainNo = newValue!;
                  });
                }),
                decoration: const InputDecoration(
                  labelText: "Train Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    width: 150,
                    child: Form(
                      key: _adminState2,
                      child: TextFormField(
                        onSaved: ((newValue) {
                          setState(() {
                            _delay = newValue!;
                          });
                        }),
                        decoration: const InputDecoration(
                          labelText: "Delay",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: SizedBox(
                    width: 125,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: onEnter,
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      label: const Text(
                        "Enter",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
