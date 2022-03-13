import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:map_app/components/components.dart';
import 'package:map_app/core/services/auth_controller.dart';

class Login extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LogoGraphicHeader(),
                  FormVerticalSpace(
                    height: 48,
                  ),
                  const Center(
                    child: Text(
                      'Login to your account!',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  FormVerticalSpace(
                    height: 48,
                  ),
                  FormInputFieldWithIcon(
                    key: const Key("User name"),
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'User name',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.emailController.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    key: const Key("User Password"),
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: 'User Password',
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      key: const Key('Sign in'),
                      labelText: 'Sign in',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          authController.signInWithUsernameAndPassword();
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
