import 'package:test/test.dart';

import '../lib/src/purchases.dart';

void main() {

  test('add purchases', () {
    final purchases = Purchases();
    expect(purchases.codes, isEmpty);
    expect(purchases['123'], isEmpty);

    purchases.add(Purchase.parse('123,11,25.83,284.13'));
    expect(purchases.codes, ['123']);
    expect(purchases['123'].length, 1);
    expect(purchases['123'][0].total.toString(), '284.13');

    purchases.add(Purchase.parse('123,1,26.42,26.42'));
    expect(purchases.codes, ['123']);
    expect(purchases['123'].length, 2);
    expect(purchases['123'][0].total.toString(), '284.13');
    expect(purchases['123'][1].total.toString(), '26.42');

    purchases.add(Purchase.parse('456,2,10.05,20.10'));
    expect(purchases.codes, ['123', '456']);
    expect(purchases['123'].length, 2);
    expect(purchases['123'][0].total.toString(), '284.13');
    expect(purchases['123'][1].total.toString(), '26.42');
    expect(purchases['456'].length, 1);
    expect(purchases['456'][0].total.toString(), '20.10');
  });
}