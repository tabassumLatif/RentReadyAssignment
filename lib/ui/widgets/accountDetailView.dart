import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../model/Account.dart';

class AccountDetail extends StatelessWidget {
  final Account account;

  const AccountDetail({
    required this.account,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(50),
        child: Center(

            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 180),
            const Padding(padding: EdgeInsets.fromLTRB(80, 8, 0, 8)),
            Center(
              child:Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: AutoSizeText(account.name, maxLines: 2, textAlign: TextAlign.center)),
                    Expanded(child: AutoSizeText(account.accountNumber, textAlign: TextAlign.center)),
                  ]

              ),
            ),
            const Padding(padding: const EdgeInsets.fromLTRB(80, 8, 0, 8)),
            Center(
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Expanded(
                     child: AutoSizeText(
                         "StateCode: ${account.stateCode == 0 ? "Active" : "Inactive"}", textAlign: TextAlign.center)),
                 Expanded(
                     child: AutoSizeText(
                         "StateOrProvince: ${account.stateOrProvince}", textAlign: TextAlign.center)),
               ],
             )
            )
          ],
        )));
  }
}
