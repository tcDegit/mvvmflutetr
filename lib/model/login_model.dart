import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User {
  @JsonKey(name: 'errorMsg')
  String errorMsg;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'data')
  UserData? data;

  User(this.errorCode, this.errorMsg);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: 'admin')
  bool? admin;

  @JsonKey(name: 'coinCount')
  int? coinCount;

  @JsonKey(name: 'collectIds')
  List<int>? collectIds;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'icon')
  String? icon;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'password')
  String? password;

  @JsonKey(name: 'publicName')
  String? publicName;

  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'type')
  int? type;

  @JsonKey(name: 'username')
  String? username;

  UserData(
      this.admin,
      this.coinCount,
      this.collectIds,
      this.email,
      this.icon,
      this.id,
      this.nickname,
      this.password,
      this.publicName,
      this.token,
      this.type,
      this.username);
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
