import 'package:flutter/material.dart';

class LockButton extends StatefulWidget {
  final Function() onDisappear;
  const LockButton({super.key, required this.onDisappear});

  @override
  State<LockButton> createState() => _LockButtonState();
}

class _LockButtonState extends State<LockButton> {
  bool _isLocked = true;
  bool _isVisable = false;

  void _onLongPress() {
    setState(() {
      _isLocked = !_isLocked;
    });
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _isVisable = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if (!_isVisable) {
      return const SizedBox();
    }
    return GestureDetector(
      onLongPress: () async {
        _onLongPress();
        await Future.delayed(const Duration(milliseconds: 600));
        widget.onDisappear();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isLocked ? Icons.lock : Icons.lock_open,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}
