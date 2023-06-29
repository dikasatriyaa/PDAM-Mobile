import "package:flutter/material.dart";
import 'package:pdam/components/newsCarousel.dart';
import 'package:pdam/components/search.dart';
import 'package:pdam/components/subMenu.dart';
import 'package:pdam/components/tiledNewsView.dart';
import 'package:pdam/components/topbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        TopBar(),
                        SizedBox(
                          height: 10,
                        ),
                        // WelcomeWidget()
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                NewsCarousel(),
                const SizedBox(
                  height: 10,
                ),
                // SizedBox(
                //   height: 10,
                // ),
                const SubMenu(),
                const SizedBox(
                  height: 10,
                ),
                Text("Berita Terbaru"),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [TiledNewsView()],

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
