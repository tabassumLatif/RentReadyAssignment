import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_ready_assignment/network/ApiController.dart';

import '../model/Account.dart';

class AccountsController extends ChangeNotifier {
  static final AccountsController _singleton = AccountsController._internal();

  factory AccountsController() {
    return _singleton;
  }

  AccountsController._internal();

  List<Account> _accountList = [];
  List<Account> _accounts = [];
  Account? _selectedAccount;
  bool _isDataLoading = false;
  bool _isListView = true;
  bool _isFilterVisible = false;
  int? _selectedStateCode;
  String? _selectedStateOrProvince;


  List<Account> get accountList {
    return _accounts;
  }

  bool get isFilterVisible {
    return _isFilterVisible;
  }

  bool get isListView {
    return _isListView;
  }

  bool get isDataLoading {
    return _isDataLoading;
  }

  Account? get selectedAccount {
    return _selectedAccount;
  }

  int? get selectedStateCode {
    return _selectedStateCode;
  }

  String? get selectedStateOrProvince {
    return _selectedStateOrProvince;
  }

  List<int> get stateCodes {
    List<int> list = [];
    groupBy(_accountList, (Account obj) => obj.stateCode).forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  List<String> get stateOrProvinces {
    List<String> list = [];
    groupBy(_accountList, (Account obj) => obj.stateOrProvince).forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  Future<void> clickFilterView() async {
    _isFilterVisible = !_isFilterVisible;
    _selectedStateCode = 0;
    _selectedStateOrProvince = "";
    notifyListeners();
  }

  Future<void> filterByStateCode(int filter) async {
    _selectedStateCode = filter;
    _accounts = _accountList.where((account) => account.stateCode == filter).toList();

    if (_selectedStateOrProvince != null && _selectedStateOrProvince!.isNotEmpty) {
      _accounts = _accountList.where((account) => account.stateOrProvince.toLowerCase().contains(_selectedStateOrProvince!.toLowerCase())).toList();
    }
    notifyListeners();
  }

  Future<void> filterByStateOrProvince(String filterText) async {
    _selectedStateOrProvince = filterText;
    _accounts = _accountList.where((account) => account.stateOrProvince.toLowerCase().contains(filterText.toLowerCase())).toList();
    _accounts = _accounts.where((account) => account.stateCode == _selectedStateCode).toList();
    notifyListeners();
  }

  Future<void> searchAccounts(String searchText) async {
    _isDataLoading = true;
    _isFilterVisible = false;
    notifyListeners();
    _accountList = await ApiController.getAccountList(searchText);
    _accounts = _accountList;
    _isDataLoading = false;
    notifyListeners();
  }

  Future<void> selectAccount(Account account) async {
    _selectedAccount = account;
    notifyListeners();
  }

  Future<void> setGridView() async {
    _isListView = false;
    notifyListeners();
  }

  Future<void> setListView() async {
    _isListView = true;
    notifyListeners();
  }
}