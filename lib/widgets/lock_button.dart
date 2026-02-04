import 'package:flutter/material.dart';

class LockButton extends StatefulWidget {
  final Function() onDisappear;
  const LockButton({super.key, required this.onDisappear});

  @override
  State<LockButton> createState() => _LockButtonState();
}

class _LockButtonState extends State<LockButton> {
  bool _isLocked = true;

  void _onLongPress() {
    setState(() {
      _isLocked = !_isLocked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        _onLongPress();
        await Future.delayed(const Duration(milliseconds: 600));
        widget.onDisappear();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isLocked ? Colors.red.shade400 : Colors.green.shade400,
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isLocked ? Icons.lock : Icons.lock_open,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
