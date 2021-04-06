import 'dart:io';

import 'fin.dart';

Future<Iterable<Item>> readCatalogItems(String name) async {
  final file = File('./data/$name.csv');
  final lines = await file.readAsLines();
  return lines.skip(1).map((line) => Item.parse(line));
}

class Catalog {

  final _items = <String, Item>{};

  Item? operator [](String ndc) => _items[ndc];

  int get length => _items.length;

  void put(Item item) {
    final ndc = item.ndc;
    final price = _items[ndc]?.price;
    if(price == null || price > item.price) {
      _items[ndc] = item;
    }
  }

  void putAll(Iterable<Item> items) {
    for(var item in items) {
      put(item);
    }
  }
}

class Item {
  final String ndc;
  final String number;
  final Price price;
  Item({
    required this.ndc,
    required this.number,
    required this.price
  });
  factory Item.parse(String input) {
    final parts = input.split(',');
    return Item(
      ndc: parts[0],
      number: parts[1],
      price: Price.parse(parts[2])
    );
  }
}
