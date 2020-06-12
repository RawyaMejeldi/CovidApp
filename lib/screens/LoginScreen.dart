import 'package:flutter/material.dart';
import 'package:telesuivi_covid_19/screens/LoginCard.dart';
import '../helpers/loginHelper.dart';

class LoginScreen extends StatefulWidget {
  static const pageRoute = './loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void dispose() {
    _addresseFocusNode.dispose();
    _confPassFocusNode.dispose();
    _passFocusNode.dispose();
    _telFocusNode.dispose();
    super.dispose();
  }

  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'tel': '',
    'username': '',
  };
  bool _isLoading = false;
  final _telFocusNode = FocusNode();
  final _addresseFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _confPassFocusNode = FocusNode();
  var init = false;

  @override
  void didChangeDependencies() {
    if (!init) _authMode = ModalRoute.of(context).settings.arguments;
    setState(() {
      init = false;
    });
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    final key=GlobalKey<ScaffoldState>();
    return Scaffold(
      key:key,
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () => Navigator.of(context).maybePop()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 40,
                      color: Theme.of(context).accentColor,
                    ),
                    Text(
                      'TELESUIVI COVID-19',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          height: 2,
                          fontWeight: FontWeight.w200,
                          color: Theme.of(context).primaryColorLight),
                    )
                  ],
                ),
                SizedBox(height: 11),
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          _authMode == AuthMode.Register ? 'Register' : 'Login',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_authMode == AuthMode.Register)
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_addresseFocusNode);
                    },
                    decoration: InputDecoration(
                      labelText: ' User name',
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                          gapPadding: 0),
                      contentPadding: const EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'taper le nom';
                      return null;
                    },
                    onSaved: (value) {
                      _authData['username'] = value;
                    },
                  ),
                const SizedBox(height: 10),
                TextFormField(
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_telFocusNode);
                  },
                  focusNode: _addresseFocusNode,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    labelText: 'email',
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'verifier votre email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                _authMode == AuthMode.LogIn
                    ? SizedBox(
                        height: _deviceSize.height * 0.05,
                      )
                    : SizedBox(
                        height: 10,
                      ),
                if (_authMode == AuthMode.Register)
                  TextFormField(
                    maxLines: 1,
                    focusNode: _telFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Mobile number',
                      prefixText: '  216+',
                      prefixIcon: Icon(Icons.phone),
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.length != 8) return 'verifier numero';
                      return null;
                    },
                    onSaved: (value) {
                      _authData['tel'] = value;
                    },
                  ),
                const SizedBox(height: 10),
                TextFormField(
                  onFieldSubmitted: (_) {
                    if (_authMode == AuthMode.Register) {
                      FocusScope.of(context).requestFocus(_confPassFocusNode);
                    }
                  },
                  focusNode: _passFocusNode,
                  textInputAction: _authMode == AuthMode.Register
                      ? TextInputAction.next
                      : TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    labelText: 'mot de passe',
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'le password doit etre 6 caractere au minimum';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.LogIn)
                  Container(
                    margin: EdgeInsets.only(
                        right: _deviceSize.width * 0.47,
                        left: _deviceSize.width * 0.01),
                    child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          '* mot de passe oublier?',
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        )),
                  ),
                const SizedBox(height: 10),
                if (_authMode == AuthMode.Register)
                  TextFormField(
                    focusNode: _confPassFocusNode,
                    textInputAction: TextInputAction.done,
                    enabled: _authMode == AuthMode.Register,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      labelText: 'confirmer le mot de passe',
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    obscureText: true,
                    validator: _authMode == AuthMode.Register
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'c\'est n\'est pas le meme mot de passe';
                            }
                            return null;
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Theme.of(context).accentColor,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_authMode == AuthMode.Register) {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                    }
                    _formKey.currentState.save();
                    setState(
                      () {
                        _isLoading = true;
                      },
                    );
                    await submitAuthForm(
                        authData: _authData,
                        key: key,
                        isLogin: _authMode == AuthMode.LogIn);
                    setState(
                      () {
                        _isLoading = false;
                      },
                    );
                  },
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          _authMode == AuthMode.LogIn ? 'login' : 'Register',
                          style: TextStyle(
                              color: Colors.white, letterSpacing: 1.3),
                          textAlign: TextAlign.center,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
