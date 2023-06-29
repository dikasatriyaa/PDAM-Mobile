// To parse this JSON data, do
//
//     final oneData = oneDataFromJson(jsonString);

import 'dart:convert';

OneData oneDataFromJson(String str) => OneData.fromJson(json.decode(str));

String oneDataToJson(OneData data) => json.encode(data.toJson());

class OneData {
  OneData({
    required this.id,
    required this.idPengaduan,
    required this.noPdam,
    required this.nama,
    required this.noHp,
    required this.alamat,
    required this.pengaduan,
    required this.foto,
    required this.tanggapan,
    required this.status,
    required this.icon,
    required this.createdAt,
  });

  String id;
  String idPengaduan;
  String noPdam;
  String nama;
  String noHp;
  String alamat;
  String pengaduan;
  String foto;
  String tanggapan;
  String status;
  String icon;
  DateTime createdAt;

  factory OneData.fromJson(Map<dynamic, dynamic> json) => OneData(
    id: json["id"],
    idPengaduan: json["id_pengaduan"],
    noPdam: json["no_pdam"],
    nama: json["nama"],
    noHp: json["no_hp"],
    alamat: json["alamat"],
    pengaduan: json["pengaduan"],
    foto: json["foto"],
    tanggapan: json["tanggapan"],
    status: json["status"],
    icon: json["icon"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "id_pengaduan": idPengaduan,
    "no_pdam": noPdam,
    "nama": nama,
    "no_hp": noHp,
    "alamat": alamat,
    "pengaduan": pengaduan,
    "foto": foto,
    "tanggapan": tanggapan,
    "status": status,
    "icon": icon,
    "created_at": createdAt.toIso8601String(),
  };
}
