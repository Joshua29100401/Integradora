import 'package:supabase_flutter/supabase_flutter.dart';
import '../view/nivel.dart';

Future<List<Nivel>> obtenerNivelesBraille() async {
  final response = await Supabase.instance.client
      .from('niveles_braille')
      .select();

  return response.map<Nivel>((json) => Nivel.fromJson(json)).toList();
}
