import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:integradora/controller/user_provider.dart'; // Asegúrate de importar tu UserProvider
import 'package:integradora/view/provider.dart';

class Lecciones extends StatefulWidget {
  const Lecciones({super.key});

  @override
  _LeccionesState createState() => _LeccionesState();
}

class _LeccionesState extends State<Lecciones> {
  late Future<List<String>> leccionesTomadas;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId =
        userProvider.user?.id; // Extraer el ID del usuario desde UserProvider
    print('ID del usuario: $userId');
    leccionesTomadas =
        userId != null ? obtenerLeccionesTomadas(userId) : Future.value([]);
  }

  Future<List<String>> obtenerLeccionesTomadas(String userId) async {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    print('TransactionProvider: $transactionProvider');
    print('Inicio de obtenerLeccionesTomadas con userId: $userId');

    try {
      // Verificar conexión a Supabase
      if (transactionProvider.supabase == null) {
        print('❌ Error: Supabase no está configurado correctamente.');
        return [];
      }

      // Realiza la consulta en Supabase
      final List<dynamic> response = await transactionProvider.supabase
          .from('progreso')
          .select('nivel_braille')
          .eq('id_usuario', userId);

      print('Datos obtenidos de Supabase: $response');

      if (response.isEmpty) {
        print('⚠️ No se encontraron lecciones tomadas para este usuario.');
        return [];
      }

      List<String> leccionesTomadas = response.map<String>((row) {
        final nivel = row['nivel_braille'];
        if (nivel == null) {
          print('⚠️ Se encontró un valor nulo en nivel_braille');
          return 'Lección desconocida';
        }
        print('Nivel encontrado: $nivel');
        return nivel.toString();
      }).toList();

      return leccionesTomadas;
    } catch (error) {
      print('❌ Error al obtener las lecciones tomadas: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecciones tomadas'),
      ),
      body: FutureBuilder<List<String>>(
        future: leccionesTomadas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          }
          final lecciones = snapshot.data ?? [];
          if (lecciones.isEmpty) {
            return const Center(
                child: Text('No hay lecciones completadas aún'));
          }
          return ListView.builder(
            itemCount: lecciones.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text('Lección ${lecciones[index]}'),
              );
            },
          );
        },
      ),
    );
  }
}
