import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:my_app/money_value.dart';

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

  @override
  Widget build(BuildContext context) {
    var groups = groupBy(
        _moneyValues, (MoneyValue moneyValue) => moneyValue.day.toString());
    var keys = groups.keys.toList()..sort();
    return Center(
      child: Column(
        children: <Widget>[
          calendar(_handleDateSelect, _selectedDate),
          ...keys.map((key) => renderMoneyGroup(key, groups[key])),
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
          crossAxisAlignment: CrossAxisAlignment.end,
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

Widget calendar(dynamic Function(DateTime date, List list) onDayPressed,
    DateTime selectedDateTime) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: CalendarCarousel(
      onDayPressed: onDayPressed,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      height: 420.0,
      selectedDateTime: selectedDateTime,
      daysHaveCircularBorder: false,
    ),
  );
}
