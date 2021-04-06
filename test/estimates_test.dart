import 'package:test/test.dart';

import '../lib/src/catalog.dart';
import '../lib/src/estimates.dart';
import '../lib/src/purchases.dart';

void main() {

  group('single purchase', () {
    test('no catalog item', () {
      final estimates = Estimates(
        Purchases()..add(Purchase.parse('03473655653,11,25.83,284.13'))
      );

      estimates.calculate(Catalog());

      expect(estimates.length, 1);
      expect(estimates.total.toString(), '0.00');
      expect(estimates.getAll()[0].impact.toString(), '0.00');
    });

    test('with catalog item but no update', () {
      final estimates = Estimates(
        Purchases()..add(Purchase.parse('03473655653,11,25.83,284.13'))
      );

      estimates.calculate(
        Catalog()..put(Item.parse('03473655653,746171,25.83'))
      );

      expect(estimates.length, 1);
      expect(estimates.total.toString(), '0.00');
      expect(estimates.getAll()[0].impact.toString(), '0.00');
    });

    test('with catalog item and price increase', () {
      final estimates = Estimates(
        Purchases()..add(Purchase.parse('03473655653,11,25.83,284.13'))
      );

      estimates.calculate(
        Catalog()..put(Item.parse('03473655653,746171,25.84'))
      );

      expect(estimates.length, 1);
      expect(estimates.total.toString(), '0.11');
      expect(estimates.getAll()[0].impact.toString(), '0.11');
    });

    test('with catalog item and price decrease', () {
      final estimates = Estimates(
        Purchases()..add(Purchase.parse('03473655653,11,25.83,284.13'))
      );

      estimates.calculate(
        Catalog()..put(Item.parse('03473655653,746171,25.82'))
      );

      expect(estimates.length, 1);
      expect(estimates.total.toString(), '-0.11');
      expect(estimates.getAll()[0].impact.toString(), '-0.11');
    });
  });

  group('multiple purchases, same ndc', () {
    test('with items from multiple catalogs', () {
      final estimates = Estimates(Purchases()
        ..add(Purchase.parse('00657778127,1,32.30,32.30'))
        ..add(Purchase.parse('00657778127,2,25.84,51.68'))
        ..add(Purchase.parse('00657778127,2,32.30,64.60'))
      );

      estimates.calculate(Catalog()
        ..put(Item.parse('00657778127,025376,29.39'))
        ..put(Item.parse('00657778127,835152,32.30'))
      );

      expect(estimates.length, 1);
      expect(estimates.total.toString(), '-1.63');
      expect(estimates.getAll()[0].ndc, '00657778127');
      expect(estimates.getAll()[0].impact.toString(), '-1.63');
    });
 });

  group('multiple purchases, different ndc', () {
    test('with catalog item, price increase and decrease', () {
      final estimates = Estimates(Purchases()
        ..add(Purchase.parse('00657778127,1,32.30,32.30'))
        ..add(Purchase.parse('00657778127,2,25.84,51.68'))
        ..add(Purchase.parse('00657778127,2,32.30,64.60'))
        ..add(Purchase.parse('48870642306,1,43.59,43.59'))
        ..add(Purchase.parse('48870642306,7,47.38,331.66'))
        ..add(Purchase.parse('48870642306,11,47.38,521.18'))
      );

      estimates.calculate(Catalog()
        ..put(Item.parse('00657778127,025376,29.39'))
        ..put(Item.parse('00657778127,835152,32.30'))
        ..put(Item.parse('48870642306,266365,47.38'))
        ..put(Item.parse('48870642306,384254,42.64'))
      );

      expect(estimates.length, 2);
      expect(estimates.total.toString(), '-87.90');
      expect(estimates.getAll()[0].ndc, '00657778127');
      expect(estimates.getAll()[0].impact.toString(), '-1.63');
      expect(estimates.getAll()[1].ndc, '48870642306');
      expect(estimates.getAll()[1].impact.toString(), '-86.27');
    });
  });
}