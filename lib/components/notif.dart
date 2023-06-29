import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdam/components/search.dart';
import 'package:pdam/components/searchbar.dart';
import 'package:pdam/constants/color_constant.dart';
import 'package:pdam/constants/style_constants.dart';
import 'package:pdam/models/pdam_models.dart';
import 'package:pdam/pages/address/addAddressPage.dart';
import 'package:pdam/pages/address/detail.dart';


class Notif extends StatefulWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {

  List<Album> listAlbum = [];
  Future getData()  async {
    var response = await http.get(Uri.parse("http://10.0.2.2/uasb/create"));
    print(response.body);
    final data = jsonDecode(response.body);
    for (Map i in data) {
      listAlbum.add(Album.fromJson(i));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PENGADUAN'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUser());
            },
            icon: Icon(Icons.search_sharp),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Expanded(child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const AddAddressPage();
                  })
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16, left: 16),
              padding: const EdgeInsets.only(left: 16),
              height: 64,
              decoration: BoxDecoration(
                color: mFillColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: mBorderColor, width: 1),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.outgoing_mail, size: 50, color: Colors.blue),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'TAMBAH PENGADUAN',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                        Text(
                          '1x 24 Jam',
                          style: TextStyle(fontSize: 15)
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text("Pengaduan Terbaru"),
          Padding(padding: EdgeInsets.only(top: 20)),
          // Expanded(
          //   flex: 8,
          //   child: FutureBuilder(
          //     future: getData(),
          //     builder: (context, snapshot) {
          //       if(snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       } else {
          //         return ListView.builder(
          //           itemCount: listAlbum.length,
          //           itemBuilder: ((context, index) {
          //             final album = listAlbum[index];
          //             return Container(
          //               child: GestureDetector(
          //                 // onTap: () {
          //                 //   Navigator.of(context).push(
          //                 //       MaterialPageRoute(builder: (context) {
          //                 //         return new Detail(
          //                 //           no_pdam : album.noPdam,
          //                 //           nama : album.nama,
          //                 //           no_hp : album.noHp,
          //                 //           pengaduan : album.pengaduan,
          //                 //           tanggapan : album.tanggapan,
          //                 //           foto: album.foto,
          //                 //           id_pengaduan: album.idPengaduan, created_at: album.createdAt, alamat: album.alamat,
          //                 //         );
          //                 //       })
          //                 //   );
          //                 // },
          //                 // child: Card(
          //                 //   child: ListTile(
          //                 //     title: Text("Pengaduan "+album.pengaduan),
          //                 //     subtitle: Text("Waktu "+album.createdAt.toString()),
          //                 //     leading: Icon(Icons.widgets),
          //                 //   ),
          //                 // ),
          //               ),
          //             );
          //           }),
          //         );
          //       }
          //     },
          //   ),
          // )
        ],
      )
    );
  }

}
