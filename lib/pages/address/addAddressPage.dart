import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:pdam/components/notif.dart';
import 'package:pdam/components/search.dart';
import 'package:pdam/constants/color_constant.dart';
import 'package:pdam/models/oneModels.dart';
import 'package:pdam/models/pdam_models.dart';
import 'package:pdam/models/pengaduan_model.dart';
import 'package:pdam/pages/home.dart';
import 'package:path/path.dart';
import 'package:cool_alert/cool_alert.dart';
import 'dart:io';

enum PengaduanType { Downloadable, Delivarable }

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController id_pdam = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController no_hp = TextEditingController();
  TextEditingController no_pdam = TextEditingController();
  TextEditingController alamt = TextEditingController();
  TextEditingController pengaduan = TextEditingController();

  File? imagepath;
  String? imagename;
  String? imagedata;

  ImagePicker imagePicker = new ImagePicker();

  void _pilihJk(String val) {
    setState(() {
      _jk = val;
    });
  }

  Future<void> getImage() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imagepath = File(getimage!.path);
      imagename = getimage.path
          .split('/')
          .last;
      imagedata = base64Encode(imagepath!.readAsBytesSync());
      print(imagepath);
      print(imagedata);
      print(imagedata);
    });
  }

  Future upload(File getimage) async {
    var stream =
    new http.ByteStream(DelegatingStream.typed(getimage.openRead()));
    var length = await getimage.length();
    var uri = Uri.parse("http://10.0.2.2/uasb/create");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("foto", stream, length,
        filename: basename(getimage.path));

    request.fields['nama'] = nama.text;
    request.fields['no_hp'] = no_hp.text;
    request.fields['name'] = imagename!;
    request.fields['no_pdam'] = no_pdam.text;
    request.fields['alamat'] = alamt.text;
    request.fields['pengaduan'] = _selectedVal;
    request.fields['id_pengaduan'] = _idNumber;

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print(response);
    }
  }

  void error(BuildContext context, String error) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(error),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  List<OneData> listAlbum = [];

  Future getData() async {
    var response = await http.get(Uri.parse("http://10.0.2.2/uasb/getLast"));
    print(response.body);
    final data = jsonDecode(response.body);
    for (Map i in data) {
      listAlbum.add(OneData.fromJson(i));
    }
  }

  PengaduanType? _pengaduanType;
  String _jk = "";
  String _idNumber = "";

  _AddAddressPageState(){
    _selectedVal = _pengaduanSizeList[0];
  }

  final _pengaduanSizeList = ["Pipa Bocor", "Air Bau"];
  String _selectedVal = "";
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 40,
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
                            itemCount: listAlbum.length,
                            itemBuilder: ((context, index) {
                              final album = listAlbum[index];
                              final now = DateTime.now();
                              if (album.idPengaduan != null) {
                                var a = "G" + album.id +
                                    now.microsecond.toString();
                                _idNumber = a;
                                return SizedBox();
                              } else {
                                var a = "G" + album.id +
                                    now.microsecond.toString();
                                _idNumber = a;
                                return SizedBox();
                              }
                            }),
                          );
                        }
                      },
                    ),
                  ),
                ),
                new TextField(
                  controller: no_pdam,
                  style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "NOMOR PDAM",
                      hintStyle: TextStyle(fontFamily: "Netflix"),
                      labelText: "NOMOR PDAM",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                new TextField(
                  controller: nama,
                  style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Nama Lengkap",
                      hintStyle: TextStyle(fontFamily: "Netflix"),
                      labelText: "Nama Lengkap",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                new TextField(
                  controller: no_hp,
                  style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Nomor HP",
                      labelText: "Nomor HP",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                // new TextField(
                //   controller: pengaduan,
                //   style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                //   decoration: new InputDecoration(
                //       hintText: "Pengaduan", labelText: "Pengaduan"),
                // ),
                new TextField(
                  controller: alamt,
                  style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Alamat",
                      labelText: "Alamat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
              ],
            ),
            Text("Jenis Pengaduan"),
            DropdownButtonFormField(

              value: _selectedVal,
                items: _pengaduanSizeList.map(
                    (e) => DropdownMenuItem(child: Text(e), value: e,)
                ).toList(),
                onChanged: (val) {
                setState(() {
                  _selectedVal = val as String;
                });
                }),
            // Row(
            //   children: [
            //     Expanded(
            //       child: RadioListTile(
            //         contentPadding: EdgeInsets.all(0.0),
            //         value: "Air Tidak Jalan",
            //         groupValue: _jk,
            //         dense: true,
            //         title: Text("Air Tidak Jalan"),
            //         onChanged: (val) {
            //           setState(() {
            //             _jk = val.toString();
            //           });
            //         },
            //       ),
            //     ),
            //     Expanded(
            //       child: RadioListTile(
            //           contentPadding: EdgeInsets.all(0.0),
            //           value: "Pipa PDAM Bocor",
            //           groupValue: _jk,
            //           dense: true,
            //           title: Text("Pipa PDAM Bocor"),
            //           onChanged: (val) {
            //             setState(() {
            //               _jk = val.toString();
            //             });
            //           }),
            //     )
            //   ],
            // ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  child: imagepath != null
                      ? Image.file(imagepath!)
                      : Text('Image Not Chose Yet'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text('Chose Image')),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (no_pdam.value.text.isEmpty) {
                        setState(() {
                          error(context, "Nomor PDAM tidak boleh kosong");
                        }); //ID gabole kosong
                      } else if (no_pdam.value.text
                          .contains(RegExp(r'[a-zA-Z]'))) {
                        setState(() {
                          error(context, "Nomor PDAM harus angka");
                          error(context, "Isi data dengan benar!");
                        }); //id harus angka
                      } else if (nama.value.text.isEmpty) {
                        setState(() {
                          error(context, "Nama Lengkap tidak boleh kosong");
                          error(context, "Isi data dengan benar!");
                        }); //nama ga bole kosong
                      } else if (no_hp.value.text.length < 5) {
                        error(context, "Naomor HP Minimal 5");
                        error(context, "Isi data dengan benar!");
                        //nama gaboleh kurang dari 5
                      } else if (alamt.value.text.isEmpty) {
                        setState(() {
                          error(context, "Alamat tidak boleh kosong");
                          error(context, "Isi data dengan benar!");
                        }); //harga gabole kosong
                      } else {
                        upload(imagepath!);
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: "Pengaduan Anda Berhasil di Kirim dengan Nomor Pengaduan : " +
                                _idNumber,
                            onConfirmBtnTap: () =>
                            {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  }))
                            });
                      }
                    },
                    child: Text("Aukan Pengaduan"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
