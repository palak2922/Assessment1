// To parse this JSON data, do
//
//     final bitCoin = bitCoinFromJson(jsonString);

import 'dart:convert';

BitCoin bitCoinFromJson(String str) => BitCoin.fromJson(json.decode(str));

String bitCoinToJson(BitCoin data) => json.encode(data.toJson());

class BitCoin {
  Time? time;
  String? disclaimer;
  String? chartName;
  Map<String, Bpi> bpi;

  BitCoin({
    this.time,
    this.disclaimer,
    this.chartName,
    required this.bpi,
  });

  factory BitCoin.fromJson(Map<String, dynamic> json) => BitCoin(
    time: Time.fromJson(json["time"]),
    disclaimer: json["disclaimer"],
    chartName: json["chartName"],
    bpi: Map.from(json["bpi"]).map((k, v) => MapEntry<String, Bpi>(k, Bpi.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "time": time!.toJson(),
    "disclaimer": disclaimer,
    "chartName": chartName,
    "bpi": Map.from(bpi).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Bpi {
  String code;
  String symbol;
  String rate;
  String description;
  double rateFloat;

  Bpi({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
    code: json["code"],
    symbol: json["symbol"],
    rate: json["rate"],
    description: json["description"],
    rateFloat: json["rate_float"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "symbol": symbol,
    "rate": rate,
    "description": description,
    "rate_float": rateFloat,
  };
}

class Time {
  String updated;
  DateTime updatedIso;
  String updateduk;

  Time({
    required this.updated,
    required this.updatedIso,
    required this.updateduk,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    updated: json["updated"],
    updatedIso: DateTime.parse(json["updatedISO"]),
    updateduk: json["updateduk"],
  );

  Map<String, dynamic> toJson() => {
    "updated": updated,
    "updatedISO": updatedIso.toIso8601String(),
    "updateduk": updateduk,
  };
}
