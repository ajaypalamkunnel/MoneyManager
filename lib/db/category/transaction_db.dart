import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/transactions/transactions_list.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactiondbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
}

// add transaction function for transaction adding
class TransactionDB implements TransactiondbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotfier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
    // print(_db.values.toString());
  }

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    //date sorting
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotfier.value.clear();
    transactionListNotfier.value.addAll(_list);
    transactionListNotfier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    print('function called');
    refresh();
  }
}
