// ignore_for_file: avoid_print

import 'package:animated_car/constants/trigger_constants.dart';
import 'package:animated_car/models/colors_enum.dart';
import 'package:animated_car/widgets/car_color_picker.dart';
import 'package:animated_car/widgets/custom_bottom_navigation_bar.dart';
import 'package:animated_car/widgets/lock_button.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CarAnimationScreen extends StatefulWidget {
  const CarAnimationScreen({super.key});

  @override
  State<CarAnimationScreen> createState() => _CarAnimationScreenState();
}

class _CarAnimationScreenState extends State<CarAnimationScreen> {
  File? _riveFile;
  RiveWidgetController? _controller;
  late ViewModelInstance _viewModelInstance;
  late ViewModelInstanceColor _carColorChangeProperty;
  late ViewModelInstanceColor _tuningColorChangeProperty;
  Color _selectedCarColor = ColorsEnum.color1.display;
  Color _selectedTuningColor = TuningColorsEnum.color1.display;
  bool _isCarLocked = true;
  bool _isFlashOn = false;
  bool _isleftDoorOpen = false;
  bool _isRightDoorOpen = false;
  bool _isHoodOpen = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final file = await File.asset(
      'assets/car_animation.riv',
      riveFactory: Factory.rive,
    );

    final controller = RiveWidgetController(file!);

    if (!mounted) return;

    setState(() {
      _riveFile = file;
      _controller = controller;
      _viewModelInstance = _controller!.dataBind(DataBind.auto());
      _carColorChangeProperty = _viewModelInstance.color('FullColor')!;
      _tuningColorChangeProperty = _viewModelInstance.color('tuning')!;
      _tuningColorChangeProperty.value = _selectedTuningColor;
      _carColorChangeProperty.value = _selectedCarColor;
    });
    Future.microtask(() {
      _trigger(TriggerConstants.carAppearance);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _riveFile?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121214),
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_riveFile != null)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  opacity: _isCarLocked ? 0.4 : 1,
                  child: RiveWidget(controller: _controller!),
                ),
              if (_isCarLocked)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 40,
                  top: MediaQuery.of(context).size.height / 2 - 30,
                  child: LockButton(
                    onDisappear: () {
                      setState(() {
                        _isCarLocked = false;
                      });
                    },
                  ),
                ),
              if (!_isCarLocked)
                Positioned(
                  top: 40,
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        spacing: 20,
                        children: [
                          const SizedBox(width: 50),
                          Text(
                            'Car Color',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          ColorSelectorRow(
                            onColorChanged:
                                (changedColor) => setState(() {
                                  _carColorChangeProperty.value = changedColor;
                                  _selectedCarColor = changedColor;
                                }),
                            initialColor: _selectedCarColor,
                            colors:
                                ColorsEnum.values
                                    .map((color) => color.display)
                                    .toList(),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Text(
                            'Tuning Color',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          ColorSelectorRow(
                            onColorChanged:
                                (changedColor) => setState(() {
                                  _tuningColorChangeProperty.value =
                                      changedColor;
                                  _selectedTuningColor = changedColor;
                                }),
                            initialColor: _selectedTuningColor,
                            colors:
                                TuningColorsEnum.values
                                    .map((color) => color.display)
                                    .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (!_isCarLocked)
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomBottomNavigationBar(
                          isFlashOn: _isFlashOn,
                          isleftDoorOpen: _isleftDoorOpen,
                          isRightDoorOpen: _isRightDoorOpen,
                          isHoodOpen: _isHoodOpen,
                          onFlashTap: _onFlashTap,
                          onLeftDoorTap: _onLeftDoorTap,
                          onRightDoorTap: _onRightDoorTap,
                          onHoodTap: _onHoodTap,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFlashTap() {
    if (_isFlashOn) {
      _trigger(TriggerConstants.lightOff);
    } else {
      _trigger(TriggerConstants.lightOn);
    }
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  void _onLeftDoorTap() {
    if (_isleftDoorOpen) {
      _trigger(TriggerConstants.leftDoorClose);
    } else {
      _trigger(TriggerConstants.leftDoorOpen);
    }
    setState(() {
      _isleftDoorOpen = !_isleftDoorOpen;
    });
  }

  void _onRightDoorTap() {
    if (_isRightDoorOpen) {
      _trigger(TriggerConstants.rightDoorClose);
    } else {
      _trigger(TriggerConstants.rightDoorOpen);
    }
    setState(() {
      _isRightDoorOpen = !_isRightDoorOpen;
    });
  }

  void _onHoodTap() {
    if (_isHoodOpen) {
      _trigger(TriggerConstants.closeHood);
    } else {
      _trigger(TriggerConstants.openHood);
    }
    setState(() {
      _isHoodOpen = !_isHoodOpen;
    });
  }

  void _trigger(String triggerName) {
    // ignore: deprecated_member_use
    final trigger = _controller?.stateMachine.trigger(triggerName);
    trigger?.fire();
  }
}
