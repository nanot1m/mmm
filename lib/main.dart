import 'package:collection/collection.dart';

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
                    if (value != 0) {
                      setState(() {
                        _moneyValues.add(buildMoneyValue(value, date));
                      });
                    }
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

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );
  @override
  Widget build(BuildContext context) {
    var groups = groupBy(
        _moneyValues, (MoneyValue moneyValue) => moneyValue.day.toString());
    var keys = groups.keys.toList()..sort();
    // var dates = new EventList<Event>();
    // var yesterday = DateTime(
    //     DateTime.now().year, DateTime.now().month, DateTime.now().day - 2);
    // dates.add(yesterday,
    //     new Event(title: 'title1', icon: _eventIcon, date: yesterday));
    return Center(
      child: Column(
        children: <Widget>[
          Calendar(
            onCalendarChanged: _handleCalendarChanged,
            onDayPressed: _handleDateSelect,
            selectedDateTime: _selectedDate,
            // markedDatesMap: dates
          ),
          ...keys.map((key) => renderMoneyGroup(key, groups[key]))
        ],
      ),
    );
  }

  Widget renderMoneyGroup(String key, List<MoneyValue> value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            formatDate(value.first.day),
            style: TextStyle(fontSize: 20),
          ),
        ),
        Column(
          children: value.map(renderMoneyValue).toList(),
        )
      ],
    );
  }

  Widget renderMoneyValue(MoneyValue moneyValue) {
    return Row(children: [
      Text(moneyValue.value.toString(),
          style: TextStyle(
              fontSize: 20,
              color: moneyValue.value > 0 ? Colors.green : Colors.red)),
      // TODO: edit
      // IconButton(
      //   icon: Icon(Icons.edit),
      //   onPressed: () {},
      //   color: Colors.lightBlue,
      // ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            _moneyValues.remove(moneyValue);
          });
        },
        color: Colors.red,
      )
    ]);
  }
}

String formatDate(DateTime day) {
  return day.day.toString() +
      '.' +
      day.month.toString() +
      '.' +
      day.year.toString();
}

MoneyValue buildMoneyValue(double value, DateTime day) {
  var sign = value > 0 ? MoneyValueSign.income : MoneyValueSign.expense;
  return MoneyValue(
      sign: sign,
      value: value,
      period: MoneyValuePeriod.none,
      title: '',
      day: day);
}
