import 'package:aimedlabtask/ControllerPage/DB/DBHelper.dart';
import 'package:aimedlabtask/ControllerPage/Model/HistoryModel.dart';
import 'package:aimedlabtask/ControllerPage/Model/SlipModel.dart';
import 'package:aimedlabtask/ControllerPage/Service/ApiService.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class SlipController extends GetxController {
  final isLoading = true.obs;
  final slipData = SlipModel().obs;
  final error = false.obs;
  @override
  void onInit() {
    super.onInit();

    fetchSlip();
  }

  DBHelper db = DBHelper();
  fetchSlip() async {
    try {
      int uniqueId = DateTime.now().toUtc().millisecondsSinceEpoch;

      error.value = false;
      isLoading(true);
      Random random = new Random();
      int randomNumber = random.nextInt(300);
      var slip = await ApiService.fetchProducts(randomNumber);
      if (slip != null) {
        slipData.value = slip;
        HistoryModel historyModel = HistoryModel(
            uniqueId: uniqueId,
            time: DateFormat.jm().format(DateTime.now()),
            advice: slip.slip.advice,
            id: slip.slip.id);
        db.saveSlip(historyModel);
      } else {
        error.value = true;
      }
    } finally {
      isLoading(false);
    }
  }
}
