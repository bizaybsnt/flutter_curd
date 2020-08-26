import 'package:flutter/material.dart';
import 'package:uahep/model/griv.dart';
import 'package:uahep/bloc/griv_bloc.dart';
import 'package:uahep/utils/validator.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Griv _griv = Griv();
  final GrivBloc grivBloc = GrivBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Grievance")),
        body: Container(padding: EdgeInsets.all(16), child: _buildForm()));
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        TextFormField(
          onSaved: (value) {
            this._griv.title = value;
          },
          decoration: InputDecoration(labelText: 'Title'),
          validator: (value) => Validator.validateEmpty(value),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          onSaved: (value) {
            this._griv.desc = value;
          },
          decoration: InputDecoration(labelText: 'Description'),
          validator: (value) => Validator.validateEmpty(value),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              grivBloc.addGriv(this._griv);
              Navigator.pop(context);
            }
          },
          child: Text('Submit'),
        ),
      ]),
    );
  }
}
