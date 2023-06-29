import 'package:flutter/material.dart';
import 'package:pdam/components/notif.dart';
import 'package:pdam/components/search.dart';
import 'package:pdam/constants/style_constants.dart';
import 'package:pdam/constants/color_constant.dart';

import 'package:pdam/pages/address/addAddressPage.dart';
import 'package:url_launcher/url_launcher.dart';
class SubMenu extends StatelessWidget {
  const SubMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: <Widget>[
          // Container(
          //   height: 140,
          //   width: MediaQuery.of(context).size.width,
          //   margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5),
          //       border: Border.all(
          //           width: 2
          //       )
          //   ),
          // ),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await call('+6282371710725');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.only(left: 16),
                    height: 64,
                    decoration: BoxDecoration(
                      color: mFillColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: mBorderColor, width: 1),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.local_phone_rounded, color: Colors.blue,),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Call Center',
                                style: mServiceTitleStyle,
                              ),
                              Text(
                                '08.00 - 16.00',
                                style: mServiceSubtitleStyle,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const Notif();
                        }));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 0),
                    padding: const EdgeInsets.only(left: 16),
                    height: 64,
                    decoration: BoxDecoration(
                      color: mFillColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: mBorderColor, width: 1),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.outgoing_mail, color: Colors.blue,),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Pengaduan',
                                style: mServiceTitleStyle,
                              ),
                              Text(
                                '1x 24 Jam',
                                style: mServiceSubtitleStyle,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}

Future<void> call(String phoneNumber) async {
  await launch('tel:$phoneNumber');
}
