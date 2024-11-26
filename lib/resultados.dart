import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  const Resultado({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém os parâmetros passados via navegação
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int acertos = args['acertos'];  // Número de acertos passados na navegação

    // Mensagem com base no número de acertos
    String mensagem;
    Color corMensagem;
    if (acertos == 10) {
      mensagem = 'Parabéns! Você acertou tudo!';
      corMensagem = Colors.green;  // Cor verde para resultado perfeito
    } else if (acertos >= 7) {
      mensagem = 'Muito bom! Você acertou $acertos de 10!';
      corMensagem = Colors.blue;   // Cor azul para bom desempenho
    } else if (acertos >= 4) {
      mensagem = 'Bom esforço! Você acertou $acertos de 10!';
      corMensagem = Colors.orange; // Cor laranja para desempenho médio
    } else {
      mensagem = 'Tente novamente! Você acertou $acertos de 10.';
      corMensagem = Colors.red;    // Cor vermelha para desempenho ruim
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFF231239), // Cor roxa
        automaticallyImplyLeading: false, // Remover a seta de voltar
      ),
        body: Container(
          color: const Color(0xFF231239), // Cor de fundo roxa
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                  mensagem,
                  style: TextStyle(
                    color: corMensagem,  // Cor dinâmica baseada nos acertos
                    fontSize: 24,         // Tamanho da fonte
                    fontWeight: FontWeight.bold, // Texto em negrito
                  ),
                  textAlign: TextAlign.center, // Centraliza o texto
                ),
                const SizedBox(height: 30), // Espaço entre o texto e o botão
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Quiz');  // Reinicia o quiz
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B4F96),  // Cor do botão
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50), // Tamanho do botão
                  ),
                  child: const Text(
                    'Reiniciar Quiz',
                    style: TextStyle(color: Colors.white),  // Cor do texto do botão
                  ),
                ),
                const SizedBox(height: 20),  // Espaço entre os botões
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');  // Vai para a tela inicial
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Cor de fundo branco
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  ),
                  child: const Text(
                    'Voltar à página inicial',
                    style: TextStyle(color: Colors.black), // Cor do texto no botão
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
