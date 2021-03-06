import 'package:flutter/material.dart';
import 'package:uahep/model/griv.dart';
import 'package:uahep/bloc/griv_bloc.dart';
import 'package:uahep/utils/validator.dart';

class AddForm extends StatefulWidget {
  final GrivBloc grivBloc;
  final Griv griv;
  AddForm({this.grivBloc, this.griv});

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Griv _griv;

  @override
  void initState() {
    super.initState();
    if (widget.griv == null) {
      _griv = Griv();
    } else {
      _griv = widget.griv;
    }
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
          initialValue: _griv.title,
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
          initialValue: _griv.desc,
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
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              if (this._griv.id == null) {
                await widget.grivBloc.addGriv(this._griv);
              } else {
                await widget.grivBloc.updateGriv(this._griv);
              }
              Navigator.pop(context);
            }
          },
          child: Text('Submit'),
        ),
      ]),
    );
  }
}
