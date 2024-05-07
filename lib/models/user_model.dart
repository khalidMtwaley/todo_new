class UserModel{
  String userId;
  String userName;
  String userEmail;
  UserModel({required this.userId,required this.userName,required this.userEmail});

  UserModel.fromJson(Map<String,dynamic> json)
  :this(
    userId: json['userId'],
    userName: json['userName'],
    userEmail: json['userEmail'],
  );

  Map<String,dynamic> toJson()=>{
    'userId': userId,
    'userName': userName,
    'userEmail': userEmail,
  };


}