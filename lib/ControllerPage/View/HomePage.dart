import 'dart:math';
import 'package:aimedlabtask/ControllerPage/Controller/SlipController.dart';
import 'package:aimedlabtask/ControllerPage/DB/DBHelper.dart';
import 'package:aimedlabtask/ControllerPage/Model/HistoryModel.dart';
import 'package:aimedlabtask/ControllerPage/Service/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  // Getx Controller
  SlipController slipController = Get.put(SlipController());

  // Current Time
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => (slipController.isLoading.value)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (slipController.error.value)
                ? Center(
                    child: Text("Please refresh page"),
                  )
                : Center(
                    child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                          slipController.slipData.value.slip.id.toString()),
                    ),
                    title: Text(
                      slipController.slipData.value.slip.advice,
                    ),
                    trailing: Text(DateFormat.jm().format(DateTime.now())),
                  ))),
        Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                fetchSlip();
              },
            ))
      ],
    );
  }

  DBHelper db = DBHelper();
  fetchSlip() async {
    try {
      slipController.error.value = false;
      slipController.isLoading(true);
      Random random = new Random();
      int randomNumber = random.nextInt(300);
      int uniqueId = DateTime.now().toUtc().millisecondsSinceEpoch;

      var slip = await ApiService.fetchProducts(randomNumber);
      if (slip != null) {
        slipController.slipData.value = slip;
        HistoryModel historyModel = HistoryModel(
            uniqueId: uniqueId,
            time: DateFormat.jm().format(DateTime.now()),
            advice: slip.slip.advice,
            id: slip.slip.id);
        db.saveSlip(historyModel);
      } else {
        slipController.error.value = true;
      }
    } finally {
      slipController.isLoading(false);
    }
  }
}
