// To parse this JSON data, do
//
//     final slipModel = slipModelFromJson(jsonString);

import 'dart:convert';

SlipModel slipModelFromJson(String str) => SlipModel.fromJson(json.decode(str));

String slipModelToJson(SlipModel data) => json.encode(data.toJson());

class SlipModel {
    SlipModel({
        this.slip,
    });

    Slip slip;

    factory SlipModel.fromJson(Map<String, dynamic> json) => SlipModel(
        slip: Slip.fromJson(json["slip"]),
    );

    Map<String, dynamic> toJson() => {
        "slip": slip.toJson(),
    };
}

class Slip {
    Slip({
        this.id,
        this.advice,
    });

    int id;
    String advice;

    factory Slip.fromJson(Map<String, dynamic> json) => Slip(
        id: json["id"],
        advice: json["advice"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "advice": advice,
    };
}
