import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;

  const CustomSearchBar({super.key, this.hintText = 'Buscar'});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}