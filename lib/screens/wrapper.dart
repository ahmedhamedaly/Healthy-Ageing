import 'package:Healthy_Ageing/screens/authenticate/authenticate.dart';
import 'package:Healthy_Ageing/screens/messaging/messaging.dart';
import 'package:Healthy_Ageing/screens/user_or_dog_owner.dart';
import 'package:flutter/material.dart';
import 'package:Healthy_Ageing/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:Healthy_Ageing/models/user.dart';

import 'home/home.dart';

bool registered = true;
String uid;

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    }

    //return Authenticate();
    //if (registered) return DogOwnerOrUserScreen();
    return Home();
    //return FormScreen();
    //return new DogOwnerOrUserScreen();
    //return DogOwnerOrUserScreen();
    return Home();

  }
}
