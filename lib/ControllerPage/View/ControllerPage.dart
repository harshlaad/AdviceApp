import 'package:aimedlabtask/ControllerPage/Controller/NavigationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'HistoryPage.dart';
import 'HomePage.dart';

class ControllerPage extends StatelessWidget {
  NavigationController navigationController = Get.put(NavigationController());
  List page = [HomePage(), HistoryPage()];
  List appTitle = ["Home Page", "History Page"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
            ],
            currentIndex: navigationController.currentIndex.value,
            selectedItemColor: Colors.amber[800],
            onTap: (val) {
              navigationController.currentIndex.value = val;
            }),
      ),
      appBar: AppBar(
        centerTitle: true,
        title:
            Obx(() => Text(appTitle[navigationController.currentIndex.value])),
      ),
      body: Obx(() => page[navigationController.currentIndex.value]),
    );
  }
}
