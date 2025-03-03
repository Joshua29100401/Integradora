import 'package:flutter/material.dart';
import 'package:integradora/controller/ejercicioSeleccionadoSenas.dart';
import 'package:integradora/controller/obtenerNivelesLenguaS.dart';
import 'package:integradora/view/nivel.dart';

class LenguaS extends StatelessWidget {
  const LenguaS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lengua de señas mexicana'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: FutureBuilder<List<Nivel>>(
        future: obtenerNivelesLenguaS(), // Llama a la función que obtiene los datos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Muestra un loader
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Muestra el error
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay niveles disponibles'));
          }

          // Muestra la lista de niveles obtenidos
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final nivel = snapshot.data![index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    // Mostrar la imagen si tiene una URL válida
                    if (nivel.imagenUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          nivel.imagenUrl,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),

                    // Mostrar la URL de la imagen
                    if (nivel.imagenUrl.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          nivel.imagenUrl, // Aquí mostramos la URL
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                    ListTile(
                      title: Text(
                        nivel.nombre,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(nivel.descripcion),
                      trailing: Chip(
                        label: Text(
                          nivel.estado ? 'Activo' : 'Inactivo',
                          style: TextStyle(
                            color: nivel.estado ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NivelDetalleSenas(nivelData: nivel.id),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
