import 'package:Healthy_Ageing/screens/authenticate/authenticate.dart';
import 'package:Healthy_Ageing/screens/messaging/messaging.dart';
import 'package:flutter/material.dart';
import 'package:Healthy_Ageing/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:Healthy_Ageing/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);



    if (user == null) {
      return Authenticate();
    }

    //return Home();
    return Messaging();
  }
}
