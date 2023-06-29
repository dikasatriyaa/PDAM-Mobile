
import 'package:flutter/material.dart';
import 'package:pdam/constants/values.dart';
import 'package:pdam/models/news.dart';
import 'package:url_launcher/url_launcher.dart';

class TiledNewsView extends StatelessWidget {
  TiledNewsView({Key? key}) : super(key: key);
  final List<News> news = StaticValues().news;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(news.length, (index) {
        News newsItem = news[index];
        int newsDescriptionLength = newsItem.description.split(' ').length;
        return GestureDetector(
          onTap: () async{
            final url = newsItem.url;
            if (await canLaunch(url)) {
              await launch(
                url,
                forceSafariVC: false,
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    newsItem.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: Text(
                            getTruncatedTitle(newsItem.title, 60),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${newsDescriptionLength >= 200 ? (newsDescriptionLength / 200).floor() : (newsDescriptionLength / 200 * 60).floor()} ${newsDescriptionLength >= 200 ? "mins" : "secs"} read",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                          Text(
                            newsItem.time,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String getTruncatedTitle(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + "..."
        : actualString;
  }
}
