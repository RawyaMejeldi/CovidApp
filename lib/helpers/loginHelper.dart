import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

Future<void> submitAuthForm({
  @required bool isLogin,
  @required Map<String, String> authData,
  @required GlobalKey<ScaffoldState> key,
}) async {
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
    key.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  } catch (err) {
    print(err);
  }
}

// final getIt = GetIt.instance;
// void setup() {
//   getIt.registerSingleton<Login>(Login());
// }
