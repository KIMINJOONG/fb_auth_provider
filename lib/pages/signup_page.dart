import 'package:fb_auth_provider/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../models/custom_error.dart';
import '../providers/signup/signup_provider.dart';
import '../providers/signup/signup_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  static const String routeName = '/signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _email, _password;
  final _passwordController = TextEditingController();

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    print('email : $_email, password : $_password, name: $_name');

    form.save();

    try {
      await context.read<SignupProvider>().signup(
            email: _email!,
            password: _password!,
            name: _name!,
          );
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupState = context.watch<SignupState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                reverse: true,
                shrinkWrap: true,
                children: [
                  Image.asset(
                    'assets/images/flutter_logo.png',
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Name',
                      prefix: Icon(Icons.account_box),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name required';
                      }
                      if (value.trim().length < 2) {
                        return 'Name must be at lease 2 characters long';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _name = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Email',
                      prefix: Icon(Icons.email),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email required';
                      }
                      if (!isEmail(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Password',
                      prefix: Icon(Icons.lock),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password required';
                      }
                      if (value.trim().length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Confirm Password',
                      prefix: Icon(Icons.lock),
                    ),
                    validator: (String? value) {
                      if (_passwordController.text != value) {
                        return 'Password not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed:
                        signupState.signupStatus == SignupStatus.submitting
                            ? null
                            : _submit,
                    child: Text(
                      signupState.signupStatus == SignupStatus.submitting
                          ? 'Loading...'
                          : 'Sign up',
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextButton(
                    onPressed:
                        signupState.signupStatus == SignupStatus.submitting
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                    child: Text('Already a member? Sign in!'),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
