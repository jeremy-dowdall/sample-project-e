import 'catalog.dart';
import 'fin.dart';
import 'purchases.dart';

class Estimates {
  final Purchases _purchases;
  final _estimates = <Estimate>[];
  Estimates(this._purchases);

  void calculate(Catalog catalog) {
    _estimates.clear();
    for(var ndc in _purchases.codes) {
      final estimate = Estimate.build(
        ndc: ndc,
        purchases: _purchases[ndc],
        newPrice:  catalog[ndc]?.price
      );
      _estimates.add(estimate);
    }
    _estimates.sort((a,b) => a.impact < b.impact ? 1 : -1);
  }

  List<Estimate> getAll() => _estimates.toList();

  int get length => _estimates.length;

  Price get total => _estimates.map((e) => e.impact).reduce((a,b) => a+b);
}

class Estimate {
  final String ndc;
  final Price impact;
  Estimate({
    required this.ndc,
    required this.impact
  });
  factory Estimate.build({required String ndc, required Iterable<Purchase> purchases, Price? newPrice}) {
    if(newPrice == null) {
      return Estimate(ndc: ndc, impact: Price());
    } else {
      final oldCost = purchases.map((p) => p.total).reduce((a,b) => a+b);
      final newCost = purchases.map((p) => newPrice*p.quantity).reduce((a,b) => a+b);
      return Estimate(ndc: ndc, impact: newCost - oldCost);
    }
  }
}
