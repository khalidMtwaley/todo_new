import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';

class UserProvider with ChangeNotifier{
  UserModel? user;

  void changeUser(UserModel newUser){
    user= newUser;
  }


}