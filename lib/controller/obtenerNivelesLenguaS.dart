import 'package:supabase_flutter/supabase_flutter.dart';
import '../view/nivel.dart';

Future<List<Nivel>> obtenerNivelesLenguaS() async {
  final response = await Supabase.instance.client
      .from('niveles_lenguaS')
      .select()
      .order('id', ascending: true); // Ordena por ID de menor a mayor

  return response.map<Nivel>((json) => Nivel.fromJson(json)).toList();
}


Future<void> actualizarEstado(Nivel nivel) async {
  final response = await Supabase.instance.client
      .from('niveles_lenguaS')
      .update({'estado': nivel.estado}) // Correcto para booleanos
      .eq('id', nivel.id)
      .select();

  print('Actualización de estado en la base de datos: ${response.toString()}');
}
