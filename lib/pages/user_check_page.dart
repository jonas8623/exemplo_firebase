import 'dart:async';
import 'package:example_firebase/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserCheckPage extends StatefulWidget {
  const UserCheckPage({Key? key}) : super(key: key);

  @override
  State<UserCheckPage> createState() => _UserCheckPageState();
}

class _UserCheckPageState extends State<UserCheckPage> {

  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginPage())
        );
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage())
        );
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive(),),
    );
  }
}
