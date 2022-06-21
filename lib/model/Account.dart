class Account {
  String accountId;
  String accountNumber;
  String name;
  int stateCode;
  String stateOrProvince;

  Account({required this.accountId, required this.accountNumber, required this.name, required this.stateCode, required this.stateOrProvince});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      accountId: json["accountid"] ?? "",
      accountNumber: json["accountnumber"] ?? "",
      name: json["name"] ?? "",
      stateCode: json["stateCode"] ?? 0,
      stateOrProvince: json["stateOrProvince"] ?? "");

  Map<String, dynamic> toJson() => {
    "accountid": accountId,
    "accountnumber": accountNumber,
    "name": name,
    "stateCode": stateCode,
    "stateOrProvince": stateOrProvince,
  };
}
