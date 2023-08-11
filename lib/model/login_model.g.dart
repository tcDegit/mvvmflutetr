// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['errorCode'] as int,
      json['errorMsg'] as String,
    )..data = json['data'] == null
        ? null
        : UserData.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'errorMsg': instance.errorMsg,
      'errorCode': instance.errorCode,
      'data': instance.data,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['admin'] as bool?,
      json['coinCount'] as int?,
      (json['collectIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      json['email'] as String?,
      json['icon'] as String?,
      json['id'] as int?,
      json['nickname'] as String?,
      json['password'] as String?,
      json['publicName'] as String?,
      json['token'] as String?,
      json['type'] as int?,
      json['username'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'admin': instance.admin,
      'coinCount': instance.coinCount,
      'collectIds': instance.collectIds,
      'email': instance.email,
      'icon': instance.icon,
      'id': instance.id,
      'nickname': instance.nickname,
      'password': instance.password,
      'publicName': instance.publicName,
      'token': instance.token,
      'type': instance.type,
      'username': instance.username,
    };
