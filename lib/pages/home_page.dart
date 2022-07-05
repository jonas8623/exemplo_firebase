import 'package:example_firebase/components/components.dart';
import 'package:example_firebase/pages/user_check_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
        elevation: 4.0,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Parabés usuário, você conseguiu acessar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 12,),
              ComponentButton(
                iconData: Icons.logout,
                text: 'Deslogar',
                onPressed: () => _logout(),
              )
            ],
          )
      ),
    );
  }

  _logout() async {
    await _firebaseAuth.signOut().then(
            (user) => Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const UserCheckPage())
            )
    );
  }
}
