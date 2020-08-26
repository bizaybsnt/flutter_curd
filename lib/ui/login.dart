import 'package:flutter/material.dart';
import 'package:uahep/utils/validator.dart';
import 'package:uahep/bloc/authentication_bloc.dart';
import 'package:uahep/bloc/base_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _globalKey = GlobalKey();
  String email;
  String password;
  AuthenticationBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = _bloc ?? Provider.of<AuthenticationBloc>(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(32),
                  child: Form(
                    key: _globalKey,
                    child: StreamBuilder<LoginState>(
                      stream: _bloc.loginState,
                      builder: (BuildContext context,
                          AsyncSnapshot<LoginState> snapshot) {
                        return _buildForm(snapshot.data, snapshot.error);
                      },
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  _buildForm(LoginState loginstate, [Object error]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          error != null ? error.toString() : "",
          style: TextStyle(color: Colors.red),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: "9841232323",
          onSaved: (value) => this.email = value,
          decoration: InputDecoration(labelText: 'Username'),
          validator: (value) => Validator.validatePhoneNumber(value),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: "password",
          onSaved: (value) => this.password = value,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password'),
          validator: (value) => Validator.validatePassword(value),
        ),
        SizedBox(
          height: 20,
        ),
        _buildLoginButton(loginstate)
      ],
    );
  }

  InkWell _buildLoginButton(LoginState loginstate) {
    return InkWell(
      onTap: loginstate == LoginState.LOADING ? null : this._onLoginClicked,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        color: Colors.blue,
        child: Center(
            child: loginstate == LoginState.LOADING
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ))
                : Text(
                    "Enter",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
      ),
    );
  }

  _onLoginClicked() async {
    if (!_globalKey.currentState.validate()) return;
    _globalKey.currentState.save();
    await _bloc.loginUser(email, password);
  }
}
