// To parse this JSON data, do
//
//     final pengaduan = pengaduanFromJson(jsonString);

import 'dart:convert';

List<Pengaduan> pengaduanFromJson(String str) => List<Pengaduan>.from(json.decode(str).map((x) => Pengaduan.fromJson(x)));

String pengaduanToJson(List<Pengaduan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pengaduan {
  Pengaduan({
    required this.id,
    required this.idPengaduan,
    required this.noPdam,
    required this.status,
    required this.icon,
    required this.created,
  });

  String id;
  String idPengaduan;
  String noPdam;
  String status;
  String icon;
  DateTime created;

  factory Pengaduan.fromJson(Map<dynamic, dynamic> json) => Pengaduan(
    id: json["id"],
    idPengaduan: json["id_pengaduan"],
    noPdam: json["no_pdam"],
    status: json["status"],
    icon: json["icon"],
    created: DateTime.parse(json["created"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "id_pengaduan": idPengaduan,
    "no_pdam": noPdam,
    "status": status,
    "icon": icon,
    "created": created.toIso8601String(),
  };


}
