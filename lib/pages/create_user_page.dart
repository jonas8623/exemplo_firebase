import 'package:example_firebase/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {

  final _nameController = TextEditingController();
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

  Widget _rowButton() {
    return ComponentButton(
      iconData: Icons.app_registration_outlined,
      text: 'Cadastrar Conta',
      onPressed: () => _registerUser(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Usuário'),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _rowField(
                  controller: _nameController,
                  keyboard: TextInputType.name,
                  text: 'Nome Completo',
                  iconData: Icons.person_rounded
              ),
              const SizedBox(height: 12,),
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
              _rowButton(),
            ],
          ),
        ),
      ),
    );
  }

  _registerUser() async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      if (userCredential != null) {
        userCredential.user!.updateDisplayName(_nameController.text);
        snack(message: 'Parabéns, o seu cadastro foi efetuado com sucesso!', type: true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const UserCheckPage()
            ),
                (route) => false);
      }
    } on FirebaseAuthException catch(error) {
        if (error.code == 'weak-password') {
          snack(message: 'Por favor, crie uma senha mais forte');
        } else if (error.code == 'email-already-in-use') {
            snack(message: 'O e-mail informado já foi cadastrado');
        }
    }
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

