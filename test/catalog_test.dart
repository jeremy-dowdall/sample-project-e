import 'package:test/test.dart';

import '../lib/src/catalog.dart';

void main() {

  test('merge items', () {
    final catalog = Catalog();

    catalog.put(Item.parse('123,456,223.45'));
    expect(catalog['123']!.price.toString(), '223.45');

    catalog.put(Item.parse('123,789,500.00'));
    expect(catalog['123']!.price.toString(), '223.45');

    catalog.put(Item.parse('123,987,100.00'));
    expect(catalog['123']!.price.toString(), '100.00');
    expect(catalog['123']!.number, '987');
  });
}