import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:integradora/controller/user_provider.dart';
import 'package:integradora/view/provider.dart';

class Lecciones extends StatefulWidget {
  const Lecciones({super.key});

  @override
  _LeccionesState createState() => _LeccionesState();
}

class _LeccionesState extends State<Lecciones> {
  late Future<List<String>> leccionesBraille;
  late Future<List<String>> leccionesSenas;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.id;

    if (userId == null) {
      setState(() {
        leccionesBraille = Future.value([]);
        leccionesSenas = Future.value([]);
      });
      return;
    }

    leccionesBraille = obtenerLeccionesTomadas(userId, 'nivel_braille');
    leccionesSenas = obtenerLeccionesTomadas(userId, 'nivel_senas');
  }

  Future<List<String>> obtenerLeccionesTomadas(
      String userId, String tipoLeccion) async {
    try {
      final transactionProvider =
          Provider.of<TransactionProvider>(context, listen: false);

      if (transactionProvider.supabase == null) {
        return [];
      }

      final List<dynamic> response = await transactionProvider.supabase
          .from('progreso')
          .select(tipoLeccion)
          .eq('id_usuario', userId);

      if (response.isEmpty) {
        return [];
      }

      return response.map<String>((row) {
        final nivel = row[tipoLeccion];
        return nivel != null ? 'Lección $nivel completada' : 'Lección desconocida';
      }).toList();
    } catch (error) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecciones Completadas'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Lecciones de Lengua de Señas completadas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: leccionesSenas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final lecciones = snapshot.data ?? [];
                return lecciones.isEmpty
                    ? const Center(
                        child: Text(
                            'No hay lecciones de Lengua de Señas completadas.'))
                    : ListView.builder(
                        itemCount: lecciones.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.check_circle,
                                color: Colors.blue),
                            title: Text(lecciones[index]),
                          );
                        },
                      );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Lecciones de Braille completadas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: leccionesBraille,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final lecciones = snapshot.data ?? [];
                return lecciones.isEmpty
                    ? const Center(
                        child: Text('No hay lecciones de Braille completadas.'))
                    : ListView.builder(
                        itemCount: lecciones.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.check_circle,
                                color: Colors.green),
                            title: Text(lecciones[index]),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
