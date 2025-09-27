import 'package:flutter/material.dart';
import 'second_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _greetingMessage = '';

  void _showGreeting() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      setState(() {
        _greetingMessage =
            '¡Hola $name! Bienvenido a tu primera app con Widgets 😊';
      });
    } else {
      setState(() {
        _greetingMessage = 'Por favor, ingresa tu nombre';
      });
    }
  }

  void _clearFields() {
    _nameController.clear();
    setState(() {
      _greetingMessage = '';
    });
  }

  // Equivalente a openSecondFragment() en Android
  void _openSecondWidget() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const SecondWidget();
      },
    );
  }

  // Equivalente a openSecondActivity() en Android
  void _openSecondScreen() {
    Navigator.of(context).pushNamed(
      '/second',
      arguments: {
        'nombre_usuario': _nameController.text.trim().isNotEmpty
            ? _nameController.text.trim()
            : 'Usuario desde Flutter',
        'contador': 42,
        'es_vip': true,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Primera App con Widgets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Widget de Bienvenida',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Este es tu primer Widget. Los Widgets son componentes reutilizables que contienen una parte de la interfaz de usuario.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ingresa tu nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _showGreeting,
                  child: const Text('Saludar'),
                ),
                OutlinedButton(
                  onPressed: _clearFields,
                  child: const Text('Limpiar'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_greetingMessage.isNotEmpty)
              Text(
                _greetingMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _openSecondWidget,
              icon: const Icon(Icons.rocket_launch),
              label: const Text('Abrir Segundo Widget'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _openSecondScreen,
              icon: const Icon(Icons.star),
              label: const Text('Abrir Nueva Pantalla'),
            ),
          ],
        ),
      ),
    );
  }
}
