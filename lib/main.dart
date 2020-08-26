import 'package:flutter/material.dart';
import 'package:uahep/bloc/authentication_bloc.dart';

import 'package:uahep/ui/home.dart';
import 'package:uahep/ui/login.dart';

import 'bloc/authentication_bloc.dart';
import 'bloc/base_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      builder: (context, bloc) => bloc ?? AuthenticationBloc(),
      child: MaterialApp(
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AuthenticationBloc _authBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = Provider.of<AuthenticationBloc>(context);

    return StreamBuilder(
      stream: _authBloc.isAuthenticated,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return Container(); 
        }
        if (snapshot.hasData && snapshot.data)
          return HomePage();
        return LoginPage();
      },
    );
  }
}
