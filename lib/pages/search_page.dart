import 'package:chatik_app/models/contact.dart';
import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchPage extends StatefulWidget {
  double _height;
  double _width;

  SearchPage(this._height, this._width);
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  AuthProvider _auth;

  String _searchInput;

  _SearchPageState() {
    _searchInput = "";
  }
  @override
  Widget build(BuildContext _context) {
    return Container(
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _createSearchPage(),
      ),
    );
  }

  Widget _createSearchPage() {
    return Builder(
      builder: (BuildContext _context) {
        _auth = Provider.of<AuthProvider>(_context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _userSearchField(),
            _usersListView(),
          ],
        );
      },
    );
  }

  Widget _userSearchField() {
    return Container(
      height: this.widget._height * 0.08,
      width: this.widget._width,
      padding: EdgeInsets.symmetric(vertical: this.widget._height * 0.02),
      child: TextField(
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        onSubmitted: (_input) {
          setState(() {
            _searchInput = _input;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          labelText: "Поиск",
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _usersListView() {
    return StreamBuilder<List<Contact>>(
        stream: DatabaseService.instance.getUsers(_searchInput),
        builder: (_context, _snapshot) {
          var _usersData = _snapshot.data;
          return _snapshot.hasData
              ? Container(
                  height: this.widget._height * 0.7,
                  child: ListView.builder(
                      itemCount: _usersData.length,
                      itemBuilder: (BuildContext _context, int _index) {
                        var _currUser = _usersData[_index];
                        return ListTile(
                          title: Text(_currUser.name),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_currUser.image),
                              ),
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Был в сети",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                timeago.format(_currUser.lastseen.toDate()),
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              : SpinKitWanderingCubes(color: Colors.blue, size: 50.0);
        });
  }
}
