// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ItemCountWidget extends StatefulWidget {
  final String itemName;
  final int initialCount;
  final ValueChanged<int> onChanged;

  const ItemCountWidget({
    super.key,
    required this.itemName,
    required this.initialCount,
    required this.onChanged,
  });

  @override
  _ItemCountWidgetState createState() => _ItemCountWidgetState();
}

class _ItemCountWidgetState extends State<ItemCountWidget> {
  late int itemCount;

  @override
  void initState() {
    super.initState();
    itemCount = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color(0xFF6552FE),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (itemCount > 0) {
                  itemCount--;
                  widget.onChanged(itemCount);
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF6552FE),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(
                Icons.remove,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            color: const Color(0xFF6552FE),
            child: Text(
              itemCount.toString(),
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                itemCount++;
                widget.onChanged(itemCount);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF6552FE),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Do not change in the code
