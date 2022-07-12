// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

// import 'dart:convert';

// List<ReportModel> reportModelFromJson(String str) => List<ReportModel>.from(json.decode(str).map((x) => ReportModel.fromJson(x)));

// String reportModelToJson(List<ReportModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportModel {
    ReportModel({
        this.id,
        this.feedId,
        this.userId,
        this.feedType,
        this.text,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    int? feedId;
    int? userId;
    String? feedType;
    String? text;
    String? createdAt;
    String? updatedAt;

    factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json["id"],
        feedId: json["feed_id"],
        userId: json["user_id"],
        feedType: json["feed_type"],
        text: json["text"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "feed_id": feedId,
        "user_id": userId,
        "feed_type": feedType,
        "text": text,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
