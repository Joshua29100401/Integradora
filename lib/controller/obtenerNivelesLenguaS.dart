import 'package:supabase_flutter/supabase_flutter.dart';
import '../view/nivel.dart';

Future<List<Nivel>> obtenerNivelesLenguaS() async {
  final response = await Supabase.instance.client
      .from('niveles_lenguaS')
      .select();

  return response.map<Nivel>((json) => Nivel.fromJson(json)).toList();
}

Future<void> actualizarEstado(Nivel nivel) async {
  final response = await Supabase.instance.client
      .from('niveles_lenguaS')
      .update({'estado': nivel.estado ? 1 : 0})
      .eq('id', nivel.id)
      .select();

  print('Actualización de estado en la base de datos: ${response.toString()}');
}
