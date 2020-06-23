import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

Future<void> submitAuthForm({
  @required bool isLogin,
  @required Map<String, String> authData,
  @required BuildContext context,
}) async {
  void _showErrorDialog({String message, BuildContext context, String titl}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: titl == null ? Text('عذرا لقد حصل خطأ ') : Text(titl),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  AuthResult authResult;
  final _auth = FirebaseAuth.instance;

  try {
    if (isLogin) {
      authResult = await _auth.signInWithEmailAndPassword(
        email: authData['email'].trim(),
        password: authData['password'],
      );
    } else {
      await Hive.init('./');
      var box = await Hive.openBox('user');
      box.put('start_date', DateTime.now().toIso8601String());
      authResult = await _auth.createUserWithEmailAndPassword(
        email: authData["email"].trim(),
        password: authData['password'],
      );

      await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData({
        'username': authData['username'].trim(),
        'email': authData['email'].trim(),
        'tel': authData['tel'].trim(),
        'start_date': DateTime.now().toIso8601String()
      });
    }
  } on PlatformException catch (err) {
    var message = 'An error occurred, pelase check your credentials!';
    if (err.message != null) {
      message = err.message;
    }
    _showErrorDialog(context:context,message: message,titl: 'errer');
  } catch (err) {
    print(err);
  }
}
