import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdam/constants/color_constant.dart';
import 'package:pdam/constants/style_constants.dart';
import 'package:pdam/models/pdam_models.dart';
import 'package:http/http.dart' as http;
import 'package:pdam/models/pengaduan_model.dart';

class Detail extends StatefulWidget {
  String no_pdam;
  String nama;
  String no_hp;
  String pengaduan;
  String tanggapan;
  String foto;
  String id_pengaduan;
  String created_at;
  String alamat;
  Detail(
      {required this.no_pdam,
        required this.nama,
        required this.no_hp,
        required this.pengaduan,
        required this.tanggapan,
        required this.foto,
        required this.id_pengaduan,
        required this.created_at, required this.alamat});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final url = "http://10.0.2.2/uasb/img/";
  List<Pengaduan> listPengaduan = [];
  Future getData() async {
    var response = await http.get(Uri.parse("http://10.0.2.2/uasb/pengaduan/" +widget.id_pengaduan));
    print(response.body);
    final data = jsonDecode(response.body);
    for (Map i in data) {
      listPengaduan.add(Pengaduan.fromJson(i));
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFffffff),
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: SizedBox(
        //     height: 10,
        //     width: 0.80,
        //     child: FlatButton(
        //       padding: EdgeInsets.zero,
        //       color: Colors.transparent,
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       child: Icon(Icons.arrow_back_ios),
        //     ),
        //   ),
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 50,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 900,
                ),
                Positioned(
                  top: 100,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 1400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Row(
                          children: [Text("Nomor : " )],
                        ),
                        Row(
                          children: [
                            Text(widget.id_pengaduan, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [Text("Tanggal Pengajuan : " )],
                        ),
                        Row(
                          children: [
                            Text(widget.created_at.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [Text("Alamat : " )],
                        ),
                        Row(
                          children: [
                            Text(widget.alamat, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [Text("Deskripsi : " )],
                        ),
                        Row(
                          children: [
                            Text(widget.pengaduan, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),)
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Container(child: Text("Tindak lanjut penyelesaian :", style: TextStyle(),))
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                widget.tanggapan,
                                style: TextStyle(color: Colors.black87, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Text(
                              "Status ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 600,
                          child: Expanded(
                            flex: 8,
                            child: FutureBuilder(
                              future: getData(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: listPengaduan.length,
                                    itemBuilder: ((context, index) {
                                      final album = listPengaduan[index];
                                      if (album.status == "Laporan Diterima") {
                                        return Container(
                                          child: Card(
                                            child: ListTile(
                                              title: Text(album.status),
                                              subtitle: Text(
                                                  album.created.toString()),
                                              leading: Icon(Icons.assignment_turned_in_outlined),
                                            ),
                                          ),
                                        );
                                      } else if (album.status == "Penugasan Regu") {
                                        return Container(
                                          child: Card(
                                            child: ListTile(
                                              title: Text(album.status),
                                              subtitle: Text(
                                                  album.created.toString()),
                                              leading: Icon(Icons.group),
                                            ),
                                          ),
                                        );
                                      } else if (album.status == "Dalam Perjalanan") {
                                        return Container(
                                          child: Card(
                                            child: ListTile(
                                              title: Text(album.status),
                                              subtitle: Text(
                                                  album.created.toString()),
                                              leading: Icon(Icons.moped),
                                            ),
                                          ),
                                        );
                                      } else if (album.status == "Ditolak") {
                                        return Container(
                                          child: Card(
                                            child: ListTile(
                                              title: Text(album.status),
                                              subtitle: Text(
                                                  album.created.toString()),
                                              leading: Icon(Icons.cancel,),
                                            ),
                                          ),
                                        );
                                      } else if (album.status == "Selesai"){
                                        return Container(
                                          child: Card(
                                            child: ListTile(
                                              title: Text(album.status),
                                              subtitle: Text(album.created.toString()),
                                              leading: Icon(Icons.assignment_turned_in_outlined, color: Colors.green,),
                                            ),
                                          ),
                                        );
                                      }else {
                                        return Container(
                                          child: Card(
                                            child: ListTile(
                                              title: Text(album.status),
                                              subtitle: Text(
                                                  album.created.toString()),
                                              leading: Icon(Icons.build_circle_outlined, color: Colors.green,),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }


}
