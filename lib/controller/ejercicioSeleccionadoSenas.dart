import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:integradora/view/views.dart'; // Asegúrate de tener esta importación

class NivelDetalleSenas extends StatefulWidget {
  final int nivelData;

  const NivelDetalleSenas({Key? key, required this.nivelData}) : super(key: key);

  @override
  _NivelDetalleState createState() => _NivelDetalleState();
}

class _NivelDetalleState extends State<NivelDetalleSenas> {
  Map<String, dynamic>? datosLeccion;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    obtenerDatosLeccion();
  }

  Future<void> obtenerDatosLeccion() async {
    try {
      final response = await Supabase.instance.client
          .from('contenido_nivel_lenguaS')
          .select()
          .eq('id_nivel', widget.nivelData)
          .maybeSingle();

      if (mounted) {
        setState(() {
          datosLeccion = response;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = "Error al obtener datos: ${e.toString()}";
          isLoading = false;
        });
      }
    }
  }

  Future<void> completarNivel(BuildContext context) async {
    final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
    final userData = transactionProvider.userData;
    final userId = userData?['id'];
    final nivelCompletado = widget.nivelData;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No se pudo obtener el ID del usuario')),
      );
      return;
    }

    print('📌 ID del usuario: $userId');
    print('📌 Nivel completado: $nivelCompletado');

    try {
      // Obtiene la lista actual de niveles completados
      final response = await transactionProvider.supabase
          .from('progreso')
          .select('nivel_senas')
          .eq('id_usuario', userId)
          .single();

      print('🔍 Respuesta obtenida de Supabase: $response');

      List<dynamic> nivelesCompletados = response['nivel_senas'] ?? [];
      List<int> nivelesList = nivelesCompletados.map((e) => int.tryParse(e.toString()) ?? 0).toList();

      // Agrega el nuevo nivel si no está en la lista
      if (!nivelesList.contains(nivelCompletado)) {
        nivelesList.add(nivelCompletado);
      }

      // Actualiza el progreso del usuario en Supabase
      await transactionProvider.supabase
          .from('progreso')
          .update({'nivel_senas': nivelesList}) // Se envía como array
          .eq('id_usuario', userId);

      print('✅ Nivel $nivelCompletado agregado correctamente.');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Lección $nivelCompletado completada de señas!')),
      );
    } catch (error) {
      print('❌ Error al actualizar el progreso: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el progreso: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lección ${widget.nivelData}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
                ? Center(
                    child: Text(
                      error!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                : datosLeccion == null
                    ? const Center(
                        child: Text(
                          "No hay datos disponibles.",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Tema:'),
                          _buildSectionContent(datosLeccion?['tema']),
                          const SizedBox(height: 10),
                          _buildSectionTitle('Antes de empezar la lección:'),
                          _buildSectionContent(datosLeccion?['informacion']),
                          const SizedBox(height: 20),
                          _buildImage(datosLeccion?['imagen_url']),
                          const Spacer(),
                          _buildCompleteButton(),
                        ],
                      ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }

  Widget _buildSectionContent(String? content) {
    return Text(
      content ?? 'Sin información',
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _buildImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Text("Error al cargar la imagen.");
          },
        ),
      );
    }
    return const Text("No hay imagen disponible.");
  }

  Widget _buildCompleteButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          await completarNivel(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Completado",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
