
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../model/Account.dart';

class AccountItem extends StatelessWidget {
  final Account account;

  const AccountItem({
    required this.account,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Center(
        child: SizedBox(
          height: 80,
          child: ListTile(
            style: ListTileStyle.drawer,
            leading: const Icon(Icons.person, size: 60),
            dense: true,
            visualDensity: const VisualDensity(vertical: -3),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: AutoSizeText(account.name, maxLines: 2)),
                  Expanded(child: AutoSizeText(account.accountNumber)),
                ],
              ),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: AutoSizeText(
                              "StateCode: ${account.stateCode == 0 ? "Active" : "Inactive"}")),
                      Expanded(
                          child: AutoSizeText(
                              "StateOrProvince: ${account.stateOrProvince}")),
                    ],
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
