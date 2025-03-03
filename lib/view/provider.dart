import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  bool isLoggedIn = false;
  bool isLoading = true;
  Map<String, dynamic>? userData;

  TransactionProvider() {
    checkSession();
  }

Future<void> checkSession() async {
  isLoading = true;
  notifyListeners();

  final session = supabase.auth.currentSession;
  if (session?.user != null) {
    print('Sesión activa encontrada para el usuario: ${session?.user.email}');
    await fetchUserData(session!.user.email!);
    isLoggedIn = true;
  } else {
    print('No se encontró sesión activa.');
    isLoggedIn = false;
  }

  isLoading = false;
  notifyListeners();
}


  /// Obtiene los datos del usuario desde la base de datos
  Future<void> fetchUserData(String email) async {
    try {
      print('Obteniendo datos para el correo: $email');
      final response = await supabase
          .from('usuarios')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (response != null) {
        print('Datos de usuario obtenidos: $response');
        userData = response;
      } else {
        print('No se encontraron datos para el correo: $email');
      }
    } catch (error) {
      debugPrint('Error al obtener los datos del usuario: $error');
    }

    notifyListeners();
  }

  /// Inicia sesión y obtiene los datos del usuario
  Future<bool> login(String username, String password) async {
    try {
      print('Iniciando sesión para el usuario: $username');
      final response = await supabase
          .from('usuarios')
          .select()
          .eq('nombre_usuario', username)
          .eq('contraseña', password)
          .maybeSingle();

      if (response != null) {
        print('Inicio de sesión exitoso. Datos de usuario: $response');
        userData = response;
        isLoggedIn = true;
        notifyListeners();
        return true;
      } else {
        print('Error: Credenciales incorrectas para el usuario: $username');
      }
    } catch (error) {
      debugPrint('Error durante el inicio de sesión: $error');
    }

    return false;
  }

  /// Cierra sesión
  Future<void> logout() async {
    await supabase.auth.signOut();
    isLoggedIn = false;
    userData = null;
    notifyListeners();
  }
}
