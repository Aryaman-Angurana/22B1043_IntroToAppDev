import 'package:budget_tracker/pages/authenticate.dart';
import 'package:budget_tracker/pages/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/Budget.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/add_budget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  return runApp(
    StreamProvider<FUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Base(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/Budget': (context) => Home(),
          '/add_budget': (context) => Add()
        },
      ),
    ),
  );
}
