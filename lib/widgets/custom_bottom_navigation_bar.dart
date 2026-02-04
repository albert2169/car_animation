import 'package:animated_car/widgets/bottom_nav_item.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Function() onFlashTap;
  final Function() onLeftDoorTap;
  final Function() onRightDoorTap;
  final Function() onHoodTap;
  final bool isFlashOn;
  final bool isleftDoorOpen;
  final bool isRightDoorOpen;
  final bool isHoodOpen;
  const CustomBottomNavigationBar({
    super.key,
    required this.onFlashTap,
    required this.onLeftDoorTap,
    required this.onRightDoorTap,
    required this.onHoodTap,
    required this.isFlashOn,
    required this.isleftDoorOpen,
    required this.isRightDoorOpen,
    required this.isHoodOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BottomNavItem(
          onTap: onFlashTap,
          name: 'Flash',
          iconLocalPath: 'assets/headlight.png',
          isActive: isFlashOn,
        ),
        BottomNavItem(
          onTap: onLeftDoorTap,
          name: 'Door L',
          iconLocalPath: 'assets/right_door.png',
          isActive: isleftDoorOpen,
        ),
        BottomNavItem(
          onTap: onRightDoorTap,
          name: 'Door R',
          iconLocalPath: 'assets/left_door.png',
          isActive: isRightDoorOpen,
        ),
        BottomNavItem(
          onTap: onHoodTap,
          name: 'Hood',
          iconLocalPath: 'assets/hood.png',
          isActive: isHoodOpen,
        ),
      ],
    );
  }
}
