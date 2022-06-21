import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/AccountsController.dart';

class FilterPanel extends StatefulWidget {
  const FilterPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  String? selectedStateOrProvince;
  int? selectedStateCode;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<AccountsController>(context, listen: false);
    return Card(
      margin: const EdgeInsets.all(0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: model.stateCodeList.isNotEmpty
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              const Text("StateCode:"),
              const SizedBox(width: 8),
              DropdownButton<int>(
                value: selectedStateCode,
                icon: const Icon(Icons.arrow_drop_down),
                //hint: const Text("State Code"),
                onChanged: (int? newValue) async {
                  await model.filterByStateCode(newValue!);
                  setState(() {
                    selectedStateCode = newValue;
                  });
                },
                items: model.stateCodeList.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value == 0 ? "Active" : "Inactive"),
                  );
                }).toList(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("State/Province:"),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedStateOrProvince,
                icon: const Icon(Icons.arrow_drop_down),
                //elevation: 16,
                onChanged: (String? newValue) async {
                  await model.filterByStateOrProvince(newValue!);
                  setState(() {
                    selectedStateOrProvince = newValue;
                  });
                },
                items: model.stateOrProvinceList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ])
            : Container(),
      ),
    );
  }
}
