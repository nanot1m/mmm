import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import 'package:my_app/money_value.dart';

import 'calendar.dart';
import 'money_controls.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Money Manager',
      theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40))))),
      home: Scaffold(
          appBar: AppBar(
            title: Text('💸 My Money Manager'),
          ),
          body: MyApp()),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State {
  DateTime _selectedDate = DateTime.now();

  List<MoneyValue> _moneyValues = [];

  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;

  _handleDateSelect(DateTime date, List list) {
    setState(() {
      _selectedDate = date;
    });

    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MoneyControls(
                  onMoneyTap: (double value) {
                    log('Clicked on: ' + value.toString());
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
  }

  _handleCalendarChanged(DateTime date) {
    setState(() {
      if (_currentMonth != date.month) _currentMonth = date.month;
      if (_currentYear != date.year) _currentYear = date.year;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Calendar(
              onCalendarChanged: _handleCalendarChanged,
              onDayPressed: _handleDateSelect,
              selectedDateTime: _selectedDate),
        ],
      ),
    );
  }
}
