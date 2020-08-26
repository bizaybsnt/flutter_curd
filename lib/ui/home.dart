import 'package:flutter/material.dart';
import 'package:uahep/bloc/base_provider.dart';
import 'package:uahep/bloc/authentication_bloc.dart';
import 'package:uahep/bloc/griv_bloc.dart';
import 'package:uahep/model/griv.dart';

import 'package:uahep/ui/addForm.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GrivBloc grivBloc = GrivBloc();
  @override
  void initState() {
    super.initState();
    grivBloc.getGrivs();
  }

  _onLogoutClick() async {
    await Provider.of<AuthenticationBloc>(context).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                this._onLogoutClick();
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: Text("Logout"),
                ),
              ];
            },
          )
        ],
      ),
      body: Center(child: Container(child: getGrivWidget())),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AddForm())),
        tooltip: 'Add List',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getGrivWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (grivs)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: grivBloc.grivs,
      builder: (BuildContext context, AsyncSnapshot<List<Griv>> snapshot) {
        return getGrivCardWidget(snapshot);
      },
    );
  }

  Widget getGrivCardWidget(AsyncSnapshot<List<Griv>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of Todo from DB.
      If that the case show user that you have empty grivs
      */
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                Griv griv = snapshot.data[itemPosition];
                final Widget dismissibleCard = new Dismissible(
                  background: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deleting",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    grivBloc.deleteGrivById(griv.id);
                  },
                  direction: DismissDirection.horizontal,
                  key: new ObjectKey(griv),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[200], width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          griv.title,
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          griv.desc,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      )),
                );
                return dismissibleCard;
              },
            )
          : Container(
              child: Center(
              child: Text('No data'),
            ));
    } else {
      return Center(
        child: Text('Loading'),
      );
    }
  }
}
