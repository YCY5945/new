class UserBean {
  String userName = "";
  int userAge = 0;


  UserBean.fromMap(Map<String, dynamic> map) {
    userName = map["userName"];
    userAge = map["age"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map["userName"] = userName;
    map["age"] = userAge;
    return map;
  }
}