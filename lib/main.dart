import 'package:flutter/material.dart';
import 'homepage.dart';
import 'quiz.dart';
import 'login_page.dart';
import 'register.dart';
import 'resultados.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Defina a aplicação com as rotas
      initialRoute: 'Login',
      routes: {
        '/': (context) => const Homepage(),
        'Login': (context) => const LoginPage(),
        'Register': (context) => const RegisterPage(),
        'Quiz': (context) => const Quiz(),
        'Resultados': (context) => const Resultado(),
      },
    );
  }
}

