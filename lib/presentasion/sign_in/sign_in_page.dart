/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_statemanagement/application/auth/cubit/auth_cubit.dart';
import 'package:flutter_cubit_statemanagement/domain/auth/login_request.dart';
import 'package:flutter_cubit_statemanagement/presentasion/home/home_page.dart';

class SignInPage extends StatefulWidget {
  static final String path = "lib/src/pages/login/login1.dart";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Error"),
                  content: Text(state.errorMessage),
                ),
              );
            } else if (state is AuthLoading) {
              print("Loading");
            } else if (state is AuthLoginSucces) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(
                  loginResponse: state.dataLogin,
                ),
              ));
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey.shade800,
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ListTile(
                          title: TextField(
                        controller: _emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Email address:",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: Colors.white30,
                            )),
                      )),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      ListTile(
                          title: TextField(
                        controller: _passwordController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Password:",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.white30,
                            )),
                      )),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: (state is AuthLoading)
                                ? _loginButtonLoading()
                                : _loginButton(context),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.grey.shade500),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  RaisedButton _loginButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        //Panggil Cubit untuk signin user
        final _requestData =
            LoginRequest(email: "eve.holt@reqres.in", password: "ssd");
        context.read<AuthCubit>().signInUser(_requestData);
      },
      color: Colors.cyan,
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white70, fontSize: 16.0),
      ),
    );
  }
}

RaisedButton _loginButtonLoading() {
  return RaisedButton(
    onPressed: null,
    color: Colors.cyan,
    child: CircularProgressIndicator(),
  );
}