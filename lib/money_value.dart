enum MoneyValueSign { income, expense }

enum MoneyValuePeriod { none, day, week, month }

class MoneyValue {
  double value = 0;
  String title = '';
  MoneyValueSign sign = MoneyValueSign.income;
  MoneyValuePeriod period = MoneyValuePeriod.none;
  DateTime day = DateTime.now();
}
