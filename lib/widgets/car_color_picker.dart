import 'package:flutter/material.dart';

class ColorSelectorRow extends StatefulWidget {
  final List<Color> colors;
  final Function(Color) onColorChanged;
  final Color initialColor;

  const ColorSelectorRow({
    super.key,
    required this.colors,
    required this.onColorChanged,
    this.initialColor = Colors.blue,
  });

  @override
  State<ColorSelectorRow> createState() => _ColorSelectorRowState();
}

class _ColorSelectorRowState extends State<ColorSelectorRow> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          widget.colors.map((color) {
            bool isActive = selectedColor == color;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = color;
                });
                widget.onColorChanged(color);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? color : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (isActive)
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
