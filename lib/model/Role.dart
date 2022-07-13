import 'package:flutter/cupertino.dart';

final String tabelRole = 'role';

class RoleFields {
  static final List<String> values = [roleName];
  static final String roleName = '_roleName';
}

class Role {
  late String RoleName;
  Role({required this.RoleName});

  static Role fromJson(Map json) => Role(RoleName: json[RoleFields.roleName]);

  Map<String, dynamic> toJson() => {RoleFields.roleName: this.RoleName};

  @override
  String toString() {
    // TODO: implement toString
    return this.RoleName;
  }
}
