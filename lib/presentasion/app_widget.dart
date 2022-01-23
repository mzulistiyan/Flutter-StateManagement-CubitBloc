import 'package:flutter/material.dart';
import 'package:flutter_cubit_statemanagement/presentasion/home/home_page.dart';
import 'package:flutter_cubit_statemanagement/presentasion/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
    );
  }
}
