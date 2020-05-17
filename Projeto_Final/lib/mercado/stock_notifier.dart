import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:projeto_final_acoes/mercado/stock.dart';

class StockNotifier with ChangeNotifier {
  List<Stock> _stockList = [];
  Stock _currentStock;

  UnmodifiableListView<Stock> get stockList => UnmodifiableListView(_stockList);

  Stock get currentstock => _currentStock;

  set stockList(List<Stock> stockList) {
    _stockList = stockList;
    notifyListeners();
  }

  set currentStock(Stock stock) {
    _currentStock = stock;
    notifyListeners();
  }
}
