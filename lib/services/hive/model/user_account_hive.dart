import 'package:hive/hive.dart';
part 'user_account_hive.g.dart';

@HiveType(typeId: 0)
class UserAccountHive extends HiveObject {
  UserAccountHive({
    this.mobileOrEmail,
    this.fullName,
    this.username,
    this.password,
    this.userId,
  });

  @HiveField(0)
  String? mobileOrEmail;
  @HiveField(1)
  String? fullName;
  @HiveField(2)
  String? username;
  @HiveField(3)
  String? password;
  @HiveField(4)
  String? userId;

  factory UserAccountHive.fromJson(Map<String, dynamic> json) => UserAccountHive(
    mobileOrEmail: json['firstName'],
    fullName: json['lastName'],
    username: json['number'],
    password: json['gender'],
    userId: json['userId'],
  );

  Map<String, dynamic> toJson() => {
    'firstName': mobileOrEmail,
    'lastName': fullName,
    'number': username,
    'gender': password,
    'userId': userId,
  };
}
