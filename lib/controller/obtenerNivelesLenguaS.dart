import 'package:supabase_flutter/supabase_flutter.dart';
import '../view/nivel.dart';

Future<List<Nivel>> obtenerNivelesLenguaS() async {
  final response = await Supabase.instance.client
      .from('niveles_lenguaS')
      .select();

  return response.map<Nivel>((json) => Nivel.fromJson(json)).toList();
}
