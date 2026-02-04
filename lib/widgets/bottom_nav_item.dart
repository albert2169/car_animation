import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final String name;
  final String iconLocalPath;
  final bool isActive;
  final Function() onTap;
  const BottomNavItem({
    super.key,
    required this.name,
    required this.iconLocalPath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: [
          Image.asset(
            iconLocalPath,
            color: isActive ? Colors.white : Color(0xFF787978),
            width: 40,
            height: 50,
          ),
          Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : Color(0xFF787978),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
