import 'package:budget_tracker/pages/authenticate.dart';
import 'package:budget_tracker/pages/home.dart';
import 'package:budget_tracker/pages/login.dart';
import 'package:budget_tracker/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


  bool signInPage = true;

  void ToggleState()
  {
    setState(() {
      signInPage = !signInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (signInPage)
    {
      return Login(toggleView: () => ToggleState());
    }    
    else{
      return Register(toggleView: () => ToggleState());
    }
  }
}



class Base extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FUser?>(context);
    print(user);
    
    if (user == null){
      return Wrapper();
    } else {
      return HomeScreen();
    }
    
  }
}