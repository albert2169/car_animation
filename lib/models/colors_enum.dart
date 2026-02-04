import 'dart:ui';

enum ColorsEnum {
  color1(display: Color(0xFF00FFFF)),
  color2(display: Color(0xFF39FF14)),
  color3(display: Color(0xFFFF00FF)),
  color4(display: Color(0xFFFFF000)),
  color5(display: Color.fromARGB(255, 255, 255, 255));

  final Color display;
  const ColorsEnum({required this.display});
}


enum TuningColorsEnum {
  color1(display: Color.fromARGB(255, 236, 17, 17)),
  color2(display: Color.fromARGB(255, 237, 137, 88)),
  color3(display: Color.fromARGB(255, 236, 223, 223)),
  color4(display: Color.fromARGB(255, 132, 131, 125));

  final Color display;
  const TuningColorsEnum({required this.display});
}
