import 'package:flutter/material.dart';

import 'package:pdam/components/api_service.dart';
import 'package:pdam/models/pdam_models.dart';
import 'package:pdam/pages/address/detail.dart';

class SearchUser extends SearchDelegate {
  FetchUserList _userList = FetchUserList();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Album>>(
        future: _userList.getuserList(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Album>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Detail(
                          no_pdam: data![index].noPdam,
                          nama: data[index].nama,
                          no_hp: data[index].noHp,
                          pengaduan: data[index].pengaduan,
                          tanggapan: data[index].tanggapan,
                          foto: data[index].foto,
                          id_pengaduan: data[index].idPengaduan,
                          alamat : data[index].alamat,
                          created_at : data[index].createdAt,
                        );
                      }));
                    },
                    child: Card(
                      child: ListTile(
                        title: Text("No PDAM " + data![index].noPdam),
                        subtitle: Text("Pengaduan " + data[index].pengaduan),
                        leading: const Icon(Icons.widgets),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('PENCARIAN BERDASARKAN NOMOR PDAM'),
    );
  }
}
