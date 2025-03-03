import 'package:flutter/material.dart';import 'package:integradora/view/provider.dart';
import 'package:provider/provider.dart';

class RevisarUser extends StatelessWidget {
  const RevisarUser({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final userData = transactionProvider.userData;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido ${userData?['nombre_usuario'] ?? "Usuario"}'),
      ),
      body: Center(
        child: userData != null
            ? Text('Tu ID de usuario es: ${userData['id']}')
            : Text('No hay usuario autenticado'),
      ),
    );
  }
}
