import 'src/catalog.dart';
import 'src/estimates.dart';
import 'src/purchases.dart';

Future<void> main() async {
  final catalog = Catalog()
    ..putAll(await readCatalogItems('catalog-1'))
    ..putAll(await readCatalogItems('catalog-2'));

  final purchases = Purchases()
    ..addAll(await readPurchases('purchases'));

  final estimates = Estimates(purchases)
    ..calculate(catalog);

  printResults(estimates);
}

void printResults(Estimates estimates) {
  final impacts = estimates.getAll();
  final width = impacts.map((i) => i.impact.toString().length).reduce((a,b) => (b>a)?b:a);

  print('''
  estimated impact on ${estimates.length} codes

  total estimated impact: ${estimates.total}

  per item:
    ndc         -> ${'impact'.padLeft(width, ' ')}
  ${estimates.getAll().map((e) => '  ${e.ndc} -> ${e.impact.toString().padLeft(width, ' ')}').join('\n  ')}
  ''');
}
