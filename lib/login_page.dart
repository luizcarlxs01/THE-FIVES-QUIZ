import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart'; // Tela inicial

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  // Verifica se o usuário já está logado
  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }
  }

  // Função de login
  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (savedUsername == usernameController.text &&
        savedPassword == passwordController.text) {
      await prefs.setBool('isLoggedIn', true); // Marca como logado
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } else {
      setState(() {
        message = 'Nome de usuário ou senha incorretos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B4F96),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: const TextStyle(color: Colors.red),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Register');
                  },
                  child: const Text(
                    'Ainda não tem uma conta? Registre-se',
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
