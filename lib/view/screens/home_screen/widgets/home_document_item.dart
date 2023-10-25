import 'package:flutter/material.dart';

class HomeDocumentItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color color;
  const HomeDocumentItem({
    super.key,
    required this.onTap,
    required this.title,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.black, width: 2)),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
