import 'package:flutter_test/flutter_test.dart';
import 'package:rent_ready_assignment/controller/AccountsController.dart';

void main() {
  test('SearchAccountsResultContainsAccounts', () async {
    final controller = AccountsController();
    await controller.searchAccounts("");
    expect(controller.accountList.length, inInclusiveRange(1, 100));
  });

  test('FilterByStateOrProvince', () async {
    final controller = AccountsController();
    await controller.searchAccounts("");
    await controller.filterByStateOrProvince("NM");
    expect(controller.accountList.length, inInclusiveRange(0, 100));
  });
  test('FilterByStateCode', () async {
    final controller = AccountsController();
    await controller.searchAccounts("");
    await controller.filterByStateCode(0);
    expect(controller.accountList.length, inInclusiveRange(1, 100));
  });

}