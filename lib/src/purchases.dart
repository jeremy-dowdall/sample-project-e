import 'dart:io';

import 'fin.dart';

Future<Iterable<Purchase>> readPurchases(String name) async {
  final file = File('./data/$name.csv');
  final lines = await file.readAsLines();
  return lines.skip(1).map((line) => Purchase.parse(line));
}

class Purchases {

  final _data = <String, List<Purchase>>{};

  List<Purchase> operator [](String ndc) => _data[ndc] ?? [];

  void add(Purchase purchase) {
    _data.putIfAbsent(purchase.ndc, () => <Purchase>[]).add(purchase);
  }

  void addAll(Iterable<Purchase> purchases) {
    for(var purchase in purchases) {
      add(purchase);
    }
  }

  List<String> get codes => _data.keys.toList();
}

class Purchase {
  final String ndc;
  final int quantity;
  final Price cost;
  final Price total;
  Purchase({
    required  this.ndc, 
    required  this.quantity, 
    required  this.cost, 
    required  this.total
  });
  factory Purchase.parse(String input) {
    final parts = input.split(',');
    return Purchase(
      ndc: parts[0],
      quantity: int.parse(parts[1]),
      cost: Price.parse(parts[2]),
      total: Price.parse(parts[3])
    );
  }
}
