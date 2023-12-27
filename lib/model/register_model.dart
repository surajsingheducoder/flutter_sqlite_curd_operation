import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  final int? id;
  final String name;
  final String email;
  final String dob;
  final String password;

  RegisterModel({
    this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.password,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    dob: json["dob"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "dob": dob,
    "password": password,
  };
}
