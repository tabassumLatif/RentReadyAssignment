import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/AccountsController.dart';
import '../../model/Account.dart';
import '../widgets/accountDetailView.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Detail")),
      backgroundColor: Colors.blueGrey,
      body: Consumer<AccountsController>(
        builder: (context, model, child) {

          Account account = model.selectedAccount!;
          return AccountDetail(account:account);
        },
      ),
    );
  }
}