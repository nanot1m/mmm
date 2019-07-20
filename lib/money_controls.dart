import 'package:flutter/material.dart';

import 'money_button.dart';

class MoneyControls extends StatefulWidget {
  final Function(int value) onMoneyTap;

  MoneyControls({this.onMoneyTap});

  @override
  _MoneyControlsState createState() =>
      _MoneyControlsState(onMoneyTap: onMoneyTap);
}

class _MoneyControlsState extends State<MoneyControls> {
  bool _isIncome = true;

  final Function(int value) onMoneyTap;

  _MoneyControlsState({this.onMoneyTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Расход'),
              onPressed: () {
                setState(() {
                  _isIncome = false;
                });
              },
            ),
            Switch(
              value: _isIncome,
              onChanged: (bool value) {
                setState(() {
                  _isIncome = value;
                });
              },
              inactiveThumbColor: Colors.redAccent,
              inactiveTrackColor: Colors.red,
            ),
            FlatButton(
              child: Text('Доход'),
              onPressed: () {
                setState(() {
                  _isIncome = true;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [1, 2, 5].map(_renderButton).toList(),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [10, 20, 50].map(_renderButton).toList(),
        ),
        SizedBox(
          height: 28,
        ),
      ],
    );
  }

  Widget _renderButton(int value) {
    var buttonColor = _isIncome ? Colors.lightBlue : Colors.red;
    return MoneyButton(
      value: _processMoneyValue(value),
      onPressed: () => handleMoneyTap(value),
      color: buttonColor,
    );
  }

  String _processMoneyValue(int value) =>
      (value * (_isIncome ? 1 : -1)).toString();

  void handleMoneyTap(int value) {
    onMoneyTap(value * (_isIncome ? 1 : -1));
  }
}
