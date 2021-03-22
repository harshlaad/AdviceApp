import 'package:aimedlabtask/ControllerPage/DB/DBHelper.dart';
import 'package:aimedlabtask/ControllerPage/Model/HistoryModel.dart';
import 'package:flutter/material.dart';

Future<List<HistoryModel>> fetchHistoryFromDatabase() async {
  DBHelper dbHelper = DBHelper();
  Future<List<HistoryModel>> history = dbHelper.getAllHistory();
  return history;
}

class HistoryPage extends StatelessWidget {
  DBHelper db = DBHelper();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder<List<HistoryModel>>(
      future: fetchHistoryFromDatabase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              HistoryModel historyModel = snapshot.data[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(historyModel.id.toString()),
                ),
                title: Text(historyModel.advice),
                trailing: Text(historyModel.time),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
