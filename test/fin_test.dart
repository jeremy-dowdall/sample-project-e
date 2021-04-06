import 'package:test/test.dart';

import '../lib/src/fin.dart';

void main() {
  group('prices default constructor', () {
    test('empty', () {
      expect(Price().toString(), '0.00');
    });

    test('dollars only', () {
      expect(Price(12).toString(), '12.00');
    });

    test('dollars and single digit cents', () {
      expect(Price(12, 3).toString(), '12.03');
    });

    test('dollars and double digit cents', () {
      expect(Price(12, 34).toString(), '12.34');
    });

    test('dollars and triple digit cents', () {
      expect(Price(12, 345).toString(), '15.45');
    });
  });

  group('prices parse constructor', () {
    test('null string', () {
      expect(Price.parse(null).toString(), '0.00');
    });

    test('empty string', () {
      expect(Price.parse('').toString(), '0.00');
    });

    test('dollars only', () {
      expect(Price.parse('12').toString(), '12.00');
    });

    test('dollars and cents', () {
      expect(Price.parse('1.23').toString(), '1.23');
    });

    test('cents only', () {
      expect(Price.parse('.12').toString(), '0.12');
    });

    test('negative amount', () {
      expect(Price.parse('-1.23').toString(), '-1.23');
    });
  });

  group('prices operators', () {
    test('addition', () {
      expect((Price(1, 2) + Price(3)).toString(), '4.02');
    });

    test('subtraction', () {
      expect((Price(1, 2) - Price(0, 2)).toString(), '1.00');
    });

    test('subtraction with negative result', () {
      expect((Price(1, 2) - Price(3)).toString(), '-1.98');
    });

    test('subtraction, cents only, with negative result', () {
      expect((Price(0, 2) - Price(0, 3)).toString(), '-0.01');
    });
  });
}