import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> submitAuthForm({
  @required bool isLogin,
  @required Map<String, String> authData,
  @required BuildContext context,
}) async {
  void _showErrorDialog({String message, BuildContext context, String titl}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: titl == null ? Text('Désole un errer ') : Text(titl),
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
      final userInfo = await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .get();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('start_date', userInfo.data['start_date']);
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('start_date', DateTime.now().toIso8601String());
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
    _showErrorDialog(context: context, message: message, titl: 'errer');
  } catch (err) {
    print(err);
  }
}
