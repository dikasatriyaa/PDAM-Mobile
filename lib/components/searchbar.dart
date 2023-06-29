import "package:flutter/material.dart";

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "PDAM",
            style: TextStyle(fontSize: 30),
          ),
          Text("Tirta Mayang Jambi")
        ],
      ),
    );
  }
}
