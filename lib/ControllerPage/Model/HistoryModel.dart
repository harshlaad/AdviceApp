// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
    HistoryModel({
        this.uniqueId,
        this.advice,
        this.id,
        this.time,
    });

    int uniqueId;
    String advice;
    int id;
    String time;

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        uniqueId: json["uniqueId"],
        advice: json["advice"],
        id: json["id"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "advice": advice,
        "id": id,
        "time": time,
    };
}
