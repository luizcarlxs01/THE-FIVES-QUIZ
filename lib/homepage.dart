import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart'; // Tela de login
import 'quiz.dart'; // Tela do quiz

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  // Função de logout
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Marca como deslogado
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('AQUI COMEÇA A DIVERSÃO')),
          backgroundColor: const Color(0xFF231239), // Cor do AppBar
        ),
          body: Container(
            color: const Color(0xFF231239), // Cor de fundo roxa
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  // Logo central
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Arredondando bordas da imagem
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 250, // Ajustando o tamanho da logo
                      height: 250,
                      fit: BoxFit.cover, // Ajuste para não ter bordas extras
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Botão "Jogar"
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Quiz()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B4F96), // Cor de fundo do botão
                      foregroundColor: Colors.white, // Cor do texto no botão
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                      ),
                      elevation: 5, // Sombras para efeito 3D
                    ),
                    child: const Text(
                      'Jogar',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botão "Logout"
                  ElevatedButton(
                    onPressed: () => _logout(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
                      backgroundColor: Colors.red, // Cor de fundo do botão
                      foregroundColor: Colors.white, // Cor do texto
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                      ),
                      elevation: 5, // Sombras para efeito 3D
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
