// ignore_for_file: avoid_print

import 'package:animated_car/constants/trigger_constants.dart';
import 'package:animated_car/widgets/lock_button.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// We strongly recommend using Data Binding instead of Rive Events for better
/// runtime control if you need to do more advanced logic than simple events.
///
/// See: https://rive.app/docs/runtimes/data-binding
///
/// This example demonstrates how to retrieve custom properties set on a Rive
/// event, and update the UI accordingly.
///
/// See: https://rive.app/docs/runtimes/events
class CarAnimationScreen extends StatefulWidget {
  const CarAnimationScreen({super.key});

  @override
  State<CarAnimationScreen> createState() => _CarAnimationScreenState();
}

class _CarAnimationScreenState extends State<CarAnimationScreen> {
  File? _riveFile;
  RiveWidgetController? _controller;
  bool _isLocked = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _riveFile = await File.asset(
      'assets/car_animation.riv',
      riveFactory: Factory.rive,
    );
    _controller = RiveWidgetController(_riveFile!);
  }

  @override
  void dispose() {
    _controller?.stateMachine.dispose();
    _riveFile?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child:
            !_isLocked
                ? Center(
                  child: LockButton(
                    onDisappear: () async {
                      setState(() {
                        _isLocked = true;
                      });
                      _trigger(TriggerConstants.carAppearance);
                    },
                  ),
                )
                : Stack(
                  children: [
                    _riveFile == null
                        ? const SizedBox()
                        : RiveWidget(controller: _controller!),
                  ],
                ),
      ),
    );
  }

  void _trigger(String triggerName) {
    // ignore: deprecated_member_use
    final trigger = _controller?.stateMachine.trigger(triggerName);
    if (trigger != null) {
      trigger.fire();
    }
  }
}
