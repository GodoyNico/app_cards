/* import 'package:app_cards/controllers/auth/auth_controller.dart';
import 'package:app_cards/entities/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController _authController;
  ReactionDisposer _disposer;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  User _user = User();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authController = Provider.of<AuthController>(context);
    _disposer = autorun((_) {
      if (_authController.loginResult != null &&
          !_authController.loginResult.status) {
        _onError(_authController.loginResult.message?.toString());
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/logo_growdev.jpg',
                scale: 3,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.mail),
                  labelText: 'E-mail',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (email) {
                  if (!EmailValidator.validate(email))
                    return 'E-mail incorreto';
                  return null;
                },
                onChanged: (value) {
                  _user.email = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.lock),
                  labelText: 'Senha',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                obscureText: true,
                validator: (password) {
                  if (_passwordController != null) return 'Senha incorreta';
                  return null;
                },
                onChanged: (value) {
                  _user.password = value;
                },
              ),
              SizedBox(height: 8),
              ButtonTheme(
                minWidth: 320,
                child: RaisedButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.black,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _signIn();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sigin() async {
    _authController.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void _onError(String result) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(result ?? "Falha ao conectar"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
 */

import 'package:app_cards/entities/user.dart';
import 'package:app_cards/services/login_mock.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _loginService = LoginService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  User _user = User();

  void _signIn() async {
    var _isValid = await _loginService.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (_isValid) {
      Navigator.of(context).pop();
    } else {
      _key.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Usuário ou senha inválidos',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
                fontSize: 18,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/logo_growdev.jpg',
                scale: 3,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.mail),
                  labelText: 'E-mail',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (email) {
                  if (!EmailValidator.validate(email))
                    return 'E-mail incorreto';
                  return null;
                },
                onChanged: (value) {
                  _user.email = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.lock),
                  labelText: 'Senha',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                obscureText: true,
                validator: (password) {
                  if (_passwordController != null) return 'Senha incorreta';
                  return null;
                },
                onChanged: (value) {
                  _user.password = value;
                },
              ),
              SizedBox(height: 8),
              ButtonTheme(
                minWidth: 320,
                child: RaisedButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.black,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _signIn();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
