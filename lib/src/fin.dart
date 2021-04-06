class Price {
  final int value;
  Price([int dollars=0, int cents=0]) : value = (dollars*100)+cents;
  factory Price.parse(String? input) {
    if(input == null || input.isEmpty) {
      return Price();
    }
    final sa = input.split('.');
    final sign = (sa[0].isNotEmpty && sa[0][0] == '-') ? -1 : 1;
    final dollars = sa[0].isEmpty ? 0 : int.parse(sa[0]);
    final cents = (sa.length > 1) ? (sign * int.parse(sa[1].padRight(2, '0'))) : 0;
    return Price(dollars, cents);
  }

  Price operator +(Price other) => Price(0, value+other.value);

  Price operator -(Price other) => Price(0, value-other.value);

  Price operator *(int multiplier) => Price(0, value*multiplier);

  bool operator <(Price other) => value < other.value;

  bool operator >(Price other) => value > other.value;

  @override
  String toString() {
    final absv = value.abs();
    final sign = (value < 0) ? '-' : '';
    final dollars = absv~/100;
    final cents = '${absv%100}'.padLeft(2, '0');
    return '$sign$dollars.$cents';
  }
}