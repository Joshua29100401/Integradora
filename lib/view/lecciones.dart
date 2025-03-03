import 'package:flutter/material.dart';
class Lecciones extends StatelessWidget {
  const Lecciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecciónes tomadas'),
      ),
      body: const Center(
        child: Text('Contenido de la página de configuración'),
      ),
    );
  }
}
