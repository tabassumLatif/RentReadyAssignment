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

  List<Account> _accountListAll = [];
  List<Account> _accountList = [];
  Account? _selectedAccount;
  bool _isloading = false;
  bool _isList = true;
  bool _isFilterPanelVisible = false;
  int? _selectedStateCode;
  String? _selectedStateOrProvince;


  List<Account> get accountList {
    return _accountList;
  }

  bool get isFilterPanelVisible {
    return _isFilterPanelVisible;
  }

  bool get isList {
    return _isList;
  }

  bool get isloading {
    return _isloading;
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

  List<int> get stateCodeList {
    List<int> list = [];
    groupBy(_accountListAll, (Account obj) => obj.stateCode).forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  List<String> get stateOrProvinceList {
    List<String> list = [];
    groupBy(_accountListAll, (Account obj) => obj.stateOrProvince).forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  Future<void> clickFilterPanel() async {
    _isFilterPanelVisible = !_isFilterPanelVisible;
    _selectedStateCode = 0;
    _selectedStateOrProvince = "";
    notifyListeners();
  }

  Future<void> filterByStateCode(int filter) async {
    _selectedStateCode = filter;
    _accountList = _accountListAll.where((account) => account.stateCode == filter).toList();

    if (_selectedStateOrProvince != null && _selectedStateOrProvince!.isNotEmpty) {
      _accountList = _accountListAll.where((account) => account.stateOrProvince.toLowerCase().contains(_selectedStateOrProvince!.toLowerCase())).toList();
    }
    notifyListeners();
  }

  Future<void> filterByStateOrProvince(String filterText) async {
    _selectedStateOrProvince = filterText;
    _accountList = _accountListAll.where((account) => account.stateOrProvince.toLowerCase().contains(filterText.toLowerCase())).toList();
    _accountList = _accountList.where((account) => account.stateCode == _selectedStateCode).toList();
    notifyListeners();
  }

  Future<void> searchAccountList(String searchText) async {
    _isloading = true;
    _isFilterPanelVisible = false;
    notifyListeners();
    _accountListAll = await ApiController.getAccountList(searchText);
    _accountList = _accountListAll;
    _isloading = false;
    notifyListeners();
  }

  Future<void> selectAccount(Account account) async {
    _selectedAccount = account;
    notifyListeners();
  }

  Future<void> setGrid() async {
    _isList = false;
    notifyListeners();
  }

  Future<void> setList() async {
    _isList = true;
    notifyListeners();
  }
}