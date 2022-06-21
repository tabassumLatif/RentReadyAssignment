import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rent_ready_assignment/controller/AccountsController.dart';

import '../widgets/accountItem.dart';
import '../widgets/filterPanel.dart';

class AccountsPage extends StatelessWidget{
  const AccountsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    AccountsController controller = AccountsController();
    controller.searchAccountList("");
    const spinkit = SpinKitWave(
      color: Colors.amber,
      size: 50.0,
    );

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey,
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Consumer<AccountsController>(
                builder: (context, model, child) {
                  return Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextField(
                                key: const Key('search'),
                                obscureText: false,
                                controller: searchController,
                                autocorrect: false,
                                keyboardType: TextInputType.text,
                                onSubmitted: (s) {
                                  model.searchAccountList(s);
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  hintText: "Search",
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await model.clickFilterPanel();
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                                Icon(Icons.filter_alt),
                                Text("Filter"),
                              ]),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.view_list_sharp),
                                  tooltip: 'Filter',
                                  onPressed: () {
                                    model.setList();
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.grid_view_sharp),
                                  tooltip: 'Filter',
                                  onPressed: () {
                                    model.setGrid();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (model.isFilterPanelVisible)
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: FilterPanel(),
                        ),
                      model.isloading
                          ? const Expanded(child: spinkit)
                          : Expanded(
                        child: model.isList
                            ? ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: model.accountList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () async {
                                    await model.selectAccount(model.accountList[index]);
                                  },
                                  child: AccountItem(account: model.accountList[index]));
                            })
                            : GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 2,
                            ),
                            itemCount: model.accountList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  key: Key("Tap$index"),
                                  onTap: () async {
                                    await model.selectAccount(model.accountList[index]);
                                  },
                                  child: AccountItem(account: model.accountList[index]));
                            }),
                      ),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }
}