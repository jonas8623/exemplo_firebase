import 'package:example_firebase/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Widget _rowField({
    required TextEditingController controller,
    required TextInputType keyboard,
    required String text
  }) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.newline,
      keyboardType: keyboard,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: text,
        filled: true,
        isDense: true,
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none
      ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none
        ),),

    );
  }

  Widget _rowButton() {
    return FractionallySizedBox(
      widthFactor: 0.60,
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.black45,),
                  borderRadius: BorderRadius.circular(16),
                ),
              child: TextButton.icon(
                icon: const Icon(Icons.login, color: Colors.white, size: 26.0,),
                label: const Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                onPressed: () {
                  login();
                },
              )
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _rowField(controller: _emailController, keyboard: TextInputType.emailAddress, text: 'E-mail'),
                const SizedBox(height: 12,),
                _rowField(controller: _passwordController, keyboard: TextInputType.text, text: "Senha"),
                const SizedBox(height: 12,),
                _rowButton()
              ],
            ),
          ),
      ),
    );
  }

  login() async {

    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      if (userCredential != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage())
        );
      }
    } on FirebaseAuthException catch(error) {
        if (error.code == 'user-not-found') {
            snack(message: 'Usuário não encontrado');
        } else if (error.code == 'wrong-password') {
            snack(message: 'Senha incorreta');
        }
    }

}

  void snack({required String message}) {
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
            content: Text(message),
            backgroundColor: Colors.redAccent,
         ),
     );
  }
}
