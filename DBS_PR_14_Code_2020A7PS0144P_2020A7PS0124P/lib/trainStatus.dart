import 'package:flutter/material.dart';
import 'package:mysql/FormInfo.dart';

class TrainStatus extends StatelessWidget {
  const TrainStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Train Status")),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [FormInfo()],
        ),
      ),
    );
  }
}
