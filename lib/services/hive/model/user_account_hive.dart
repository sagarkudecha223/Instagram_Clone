import 'package:hive/hive.dart';
part 'user_account_hive.g.dart';

@HiveType(typeId: 0)
class UserAccountHive extends HiveObject {
  UserAccountHive({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.gender,
    this.userId,
  });

  @HiveField(0)
  String? firstName;
  @HiveField(1)
  String? lastName;
  @HiveField(2)
  String? mobileNumber;
  @HiveField(3)
  String? gender;
  @HiveField(4)
  String? userId;

  factory UserAccountHive.fromJson(Map<String, dynamic> json) => UserAccountHive(
    firstName: json['firstName'],
    lastName: json['lastName'],
    mobileNumber: json['number'],
    gender: json['gender'],
    userId: json['userId'],
  );

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'number': mobileNumber,
    'gender': gender,
    'userId': userId,
  };
}
