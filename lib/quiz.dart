import 'package:flutter/material.dart';
import 'quiz_dados.dart'; // Certifique-se de que o arquivo quiz_dados.dart está correto

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Map<String, dynamic>> perguntas = []; // Lista para armazenar as perguntas embaralhadas
  int perguntaAtual = 0;
  int acertos = 0;

  @override
  void initState() {
    super.initState();
    // Embaralha as perguntas quando a tela é inicializada
    perguntas = List.from(quiz);
    perguntas.shuffle(); // Embaralha a lista de perguntas
  }

  void verificarResposta(int indiceSelecionado) {
    if (perguntas[perguntaAtual]['alternativa_correta'] == indiceSelecionado) {
      acertos++;
    }

    setState(() {
      perguntaAtual++;  // Passa para a próxima pergunta
    });
  }

  @override
  Widget build(BuildContext context) {
    if (perguntaAtual >= perguntas.length) {
      // Use addPostFrameCallback para garantir que a navegação ocorra após a construção da tela
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, 'Resultados', arguments: {'acertos': acertos});
      });

      return const SizedBox.shrink();  // Retorna um widget vazio enquanto navega
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF231239),
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Retorna para a tela anterior
          },
          iconSize: 35, // Aumenta o tamanho do ícone de voltar
        ),
      ),
      body: Container(
            color: const Color(0xFF231239), // Cor de fundo para o quiz
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                // Indicador de pergunta no canto superior direito
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Pergunta ${perguntaAtual + 1} de ${perguntas.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                // Pergunta atual
                Text(
                  perguntas[perguntaAtual]['pergunta'],
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Lista de opções de respostas
                ...List.generate(perguntas[perguntaAtual]['respostas'].length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () => verificarResposta(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9B4F96),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                        ),
                        elevation: 5, // Sombras para dar um efeito 3D
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.07,
                        ), // Tamanho fixo para todos os botões
                      ),
                      child: Text(
                        perguntas[perguntaAtual]['respostas'][index],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
