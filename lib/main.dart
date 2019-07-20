import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40))))),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Welcome to Flutter'),
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

  _handleDateSelect(DateTime date, List list) {
    setState(() {
      _selectedDate = date;
    });

    log('message');

    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[MoneyControls()],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          calendar(_handleDateSelect, _selectedDate),
        ],
      ),
    );
  }
}

class MoneyControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MoneyButton(
              value: '1',
              onPressed: () {},
            ),
            MoneyButton(
              value: '2',
              onPressed: () {},
            ),
            MoneyButton(
              value: '5',
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MoneyButton(
                value: '10',
                onPressed: () {},
              ),
              MoneyButton(
                value: '20',
                onPressed: () {},
              ),
              MoneyButton(
                value: '50',
                onPressed: () {},
              ),
            ]),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

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
