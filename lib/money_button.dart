import 'package:flutter/material.dart';

class MoneyButton extends StatelessWidget {
  final String value;
  final Color color;

  final VoidCallback onPressed;

  MoneyButton({@required this.value, this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Ink(
      decoration: ShapeDecoration(
          color: color == null ? Colors.lightBlue : color,
          shape: CircleBorder()),
      child: IconButton(
        icon: Text(value, style: TextStyle(color: Colors.white)),
        onPressed: onPressed,
        splashColor: Colors.white.withOpacity(0.6),
      ),
    ));
  }
}
