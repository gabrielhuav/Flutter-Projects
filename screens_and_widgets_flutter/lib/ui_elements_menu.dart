import 'package:flutter/material.dart';

class UIElementsMenu extends StatelessWidget {
  const UIElementsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets de Layouts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ejemplo de un Column simple
            const Text(
              'Usando Column para apilar elementos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(height: 50, width: 50, color: Colors.blue),
            const SizedBox(height: 10),
            Container(height: 50, width: 50, color: Colors.green),
            const SizedBox(height: 10),
            Container(height: 50, width: 50, color: Colors.red),

            const SizedBox(height: 40),

            // Un Row dentro del Column para un diseño más complejo
            const Text(
              'Usando Row dentro de un Column',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 50, width: 50, color: Colors.yellow),
                const SizedBox(width: 10),
                Container(height: 50, width: 50, color: Colors.orange),
                const SizedBox(width: 10),
                Container(height: 50, width: 50, color: Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
