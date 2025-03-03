import 'package:flutter/material.dart';
class Desempeno extends StatelessWidget {
  const Desempeno({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: const Center(
        child: Text('Contenido de la página de configuración'),
      ),
    );
  }
}