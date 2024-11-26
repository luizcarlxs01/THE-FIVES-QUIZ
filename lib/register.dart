import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';  // Tela de login

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String message = '';

  // Função para salvar os dados do usuário
  _register() async {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        message = 'As senhas não coincidem';
      });
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('password', passwordController.text);

    setState(() {
      message = 'Usuário registrado com sucesso!';
    });

    // Redireciona para a tela de login após registro
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar-se'),
        backgroundColor: const Color(0xFF231239),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
        color: const Color(0xFF231239),
        child: Center(
          child: ConstrainedBox
          (constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nome de Usuário',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9B4F96),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: const Text('Registrar'),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: const TextStyle(color: Colors.red),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Login');
                },
                child: const Text(
                  'Já tem uma conta? Faça login',
                  style: TextStyle(color: Colors.white),
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
