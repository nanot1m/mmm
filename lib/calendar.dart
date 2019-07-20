import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class Calendar extends StatelessWidget {
  final dynamic Function(DateTime date, List list) onDayPressed;
  final dynamic Function(DateTime date) onCalendarChanged;
  final EventList<Event> markedDatesMap;

  final DateTime selectedDateTime;
  Calendar(
      {this.onDayPressed,
      this.selectedDateTime,
      this.onCalendarChanged,
      this.markedDatesMap});

  @override
  Widget build(BuildContext context) {
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
          onCalendarChanged: onCalendarChanged,
          markedDatesMap: markedDatesMap,
          firstDayOfWeek: 1,
          markedDateIconBuilder: (Event event) {
            return event.icon;
          }),
    );
  }
}
