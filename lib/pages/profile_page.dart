import 'package:chatik_app/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/database_service.dart';

class ProfilePage extends StatelessWidget {
  final double _height;
  final double _width;

  AuthProvider _auth;

  ProfilePage(this._height, this._width) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: _height,
      width: _width,
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _createProfilePage(),
      ),
    );
  }

  Widget _createProfilePage() {
    return Builder(
      builder: (BuildContext _context) {
        _auth = Provider.of<AuthProvider>(_context);
        return StreamBuilder<Contact>(
            stream: DatabaseService.instance.getUserData(_auth.user.uid),
            builder: (_context, _snapshot) {
              var _userData = _snapshot.data;
              return _snapshot.hasData
                  ? Align(
                      child: SizedBox(
                        height: _height * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _userImage(_userData.image),
                            _userName(_userData.name),
                            _userEmail(_userData.email),
                            _logoutButton(),
                          ],
                        ),
                      ),
                    )
                  : SpinKitWanderingCubes(
                      color: Colors.blue,
                      size: 50.0,
                    );
            });
      },
    );
  }

  Widget _userImage(String _image) {
    double _imageRadius = _height * 0.2;
    return Container(
      height: _imageRadius,
      width: _imageRadius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_imageRadius),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(_image),
        ),
      ),
    );
  }

  Widget _userName(String _userName) {
    return Container(
      height: _height * 0.05,
      width: _width,
      child: Text(
        _userName,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }

  Widget _userEmail(String _userEmail) {
    return Container(
      height: _height * 0.03,
      width: _width,
      child: Text(
        _userEmail,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white24, fontSize: 15),
      ),
    );
  }

  Widget _logoutButton() {
    return Container(
      height: _height * 0.06,
      width: _width * 0.8,
      child: MaterialButton(
        onPressed: () {
          _auth.logoutUser(() {});
        },
        color: Colors.red,
        child: Text(
          "Выход",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
