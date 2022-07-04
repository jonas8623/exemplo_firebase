import 'package:example_firebase/components/components.dart';
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
    required String text,
    required IconData iconData,
  }) {
    return ComponentTextFormField(
      controller: controller,
      keyboard: keyboard,
      text: text,
      icon: iconData,
    );
  }

  Widget _rowButton({required IconData icon, required String text, required GestureTapCallback onPressed}) {
    return ComponentButton(
      iconData: icon,
      text: text,
      onPressed: onPressed,
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
                _rowField(
                    controller: _emailController,
                    keyboard: TextInputType.emailAddress,
                    text: 'E-mail',
                    iconData: Icons.email
                ),
                const SizedBox(height: 12,),
                _rowField(
                    controller: _passwordController,
                    keyboard: TextInputType.text,
                    text: "Senha",
                    iconData: Icons.password
                ),
                const SizedBox(height: 12,),
                _rowButton(icon: Icons.login, text: 'Entrar', onPressed: () => _login()),
                const SizedBox(height: 12,),
                _rowButton(icon: Icons.person_add_alt_1, text: 'Criar Conta', onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateUserPage()))),
              ],
            ),
          ),
      ),
    );
  }

  _login() async {

    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      if (userCredential != null) {
        snack(message: 'Parabéns, você está logado', type: true);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage())
        );
      }
    } on FirebaseAuthException catch(error) {
        if (error.code == 'user-not-found') {
            _passwordController.clear();
            snack(message: 'Não foi possível encontrar usuário');
        } else if (error.code == 'wrong-password') {
            _passwordController.clear();
            snack(message: 'Por favor insira uma senha correta');
        }
    }
    _passwordController.clear();
}

  void snack({required String message, bool? type = false}) {
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
            content: Text(message),
            backgroundColor: type == true ? Colors.green : Colors.redAccent,
         ),
     );
  }
}
