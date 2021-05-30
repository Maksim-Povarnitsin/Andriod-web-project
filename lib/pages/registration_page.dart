import 'dart:io';

import 'package:chatik_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../services/media_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/database_service.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  double _deviceHeight;
  double _deviceWidth;

  GlobalKey<FormState> _formKey;
  AuthProvider _auth;

  _RegistrationPageState() {
    _formKey = GlobalKey<FormState>();
  }

  String _name;
  String _email;
  String _pass;
  File _avatarImage;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
          alignment: Alignment.center,
          child: ChangeNotifierProvider<AuthProvider>.value(
            value: AuthProvider.instance,
            child: createRegistrationPage(),
          )),
    );
  }

  Widget createRegistrationPage() {
    return Builder(
      builder: (BuildContext _context) {
        _auth = Provider.of<AuthProvider>(_context);
        return Container(
          height: _deviceHeight * 0.75,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _createHeading(),
              _createInputForm(),
              _registerButton(),
              _backToLoginPageButton()
            ],
          ),
        );
      },
    );
  }

  Widget _createHeading() {
    return Container(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Давайте начнем!",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Text(
            "Пожалуйста, введите ваши данные.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }

  Widget _createInputForm() {
    return Container(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _imageSelectorWidget(),
            _nameField(),
            _emailField(),
            _passwordField(),
          ],
        ),
      ),
    );
  }

  Widget _imageSelectorWidget() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          PickedFile _pickedFile =
              await MediaService.instance.getImageFromLibrary();
          File _image = File(_pickedFile.path);
          setState(() {
            _avatarImage = _image;
          });
        },
        child: Container(
          height: _deviceHeight * 0.10,
          width: _deviceHeight * 0.10,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: _avatarImage != null
                    ? FileImage(_avatarImage)
                    : NetworkImage(
                        "https://cdn.icon-icons.com/icons2/20/PNG/256/business_man_user_support_supportfortheuser_aquestion_theclient_2330.png")),
          ),
        ),
      ),
    );
  }

  Widget _nameField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input.length != 0 ? null : "Введите нормальное имя";
      },
      onSaved: (_input) {
        setState(() {
          _name = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Имя",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input.length != 0 && _input.contains("@")
            ? null
            : "Введите нормальное мыло"; // проверяем что мыло не пустое и есть штрудель
      },
      onSaved: (_input) {
        setState(() {
          _email = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Email",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input.length != 0 ? null : "Введите пароль";
      },
      onSaved: (_input) {
        setState(() {
          _pass = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Пароль",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return _auth.status != AuthStatus.Authenticating
        ? Container(
            height: _deviceHeight * 0.06,
            width: _deviceWidth,
            child: MaterialButton(
              onPressed: () {
                if (_formKey.currentState.validate() && _avatarImage != null) {
                  _auth.registerUserWithEmailAndPass(_email, _pass,
                      (String _uid) async {
                    var _result = await CloudStorageService.instance
                        .uploadUserImage(_uid, _avatarImage);
                    var _imageURL = await _result.ref.getDownloadURL();
                    await DatabaseService.instance
                        .createUser(_uid, _name, _email, _imageURL);
                  });
                }
              },
              color: Colors.blue,
              child: Text(
                "Регистрация",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }

  Widget _backToLoginPageButton() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.goBack();
      },
      child: Container(
        height: _deviceHeight * 0.06,
        width: _deviceWidth,
        child: Icon(
          Icons.arrow_back,
          size: 30,
        ),
      ),
    );
  }
}
