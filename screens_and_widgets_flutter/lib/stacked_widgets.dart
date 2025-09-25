import 'package:flutter/material.dart';

class StackedWidgetsExample extends StatelessWidget {
  const StackedWidgetsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Stack'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.grey[300],
          child: Stack(
            children: [
              // Fondo de la imagen
              Center(
                child: Image.network(
                  'https://via.placeholder.com/250',
                  fit: BoxFit.cover,
                ),
              ),
              // Texto superpuesto en la parte inferior
              const Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  'Texto sobre la imagen',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),
              // Un icono en la esquina superior derecha
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.favorite, color: Colors.red, size: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
