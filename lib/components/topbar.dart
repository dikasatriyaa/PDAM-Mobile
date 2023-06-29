import 'package:flutter/material.dart';
import 'package:pdam/components/notif.dart';
import 'package:pdam/components/searchbar.dart';


class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "PDAM",
              style: TextStyle(fontSize: 30),
            ),
            Text("Tirta Mayang Jambi")
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        // GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) {
        //           return const Notif();
        //         })
        //     );
        //   },
        //   child: const Icon(
        //     Icons.circle_notifications_outlined,
        //     size: 30,
        //   ),
        // )
      ],
    );
  }
}
