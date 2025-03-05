import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:integradora/controller/user_provider.dart'; // Importa tu UserProvider
import 'package:integradora/controller/clase_usuario.dart'; // Importa tu modelo de usuario

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
    final email = session?.user?.email;

    if (email != null) {
      print('✅ Sesión activa encontrada para el usuario: $email');
      await fetchUserData(email);
      isLoggedIn = true;
    } else {
      print('⚠️ No se encontró sesión activa.');
      isLoggedIn = false;
    }

    isLoading = false;
    notifyListeners();
  }

  /// Obtiene los datos del usuario desde la base de datos
  Future<void> fetchUserData(String email) async {
    try {
      print('🔍 Obteniendo datos para el correo: $email');
      final response = await supabase
          .from('usuarios')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (response != null) {
        print('✅ Datos de usuario obtenidos: $response');
        userData = response;
      } else {
        print('⚠️ No se encontraron datos para el correo: $email');
      }
    } catch (error) {
      debugPrint('❌ Error al obtener los datos del usuario: $error');
    }

    notifyListeners();
  }

  /// Inicia sesión y obtiene los datos del usuario
  Future<bool> login(String username, String password, BuildContext context) async {
    try {
      print('🔐 Iniciando sesión para el usuario: $username');
      final response = await supabase
          .from('usuarios')
          .select()
          .eq('nombre_usuario', username)
          .eq('contraseña', password)
          .maybeSingle();

      if (response != null) {
        print('✅ Inicio de sesión exitoso. Datos de usuario: $response');
        userData = response;

        // Guardamos el usuario en UserProvider
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final user = UserModel.fromJson(response);
        userProvider.setUser(user);

        isLoggedIn = true;
        notifyListeners();
        return true;
      } else {
        print('❌ Error: Credenciales incorrectas para el usuario: $username');
      }
    } catch (error) {
      debugPrint('❌ Error durante el inicio de sesión: $error');
    }

    return false;
  }

  /// Cierra sesión
  Future<void> logout(BuildContext context) async {
    await supabase.auth.signOut();
    isLoggedIn = false;
    userData = null;

    // Limpiamos el usuario de UserProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.clearUser();

    notifyListeners();
  }
}
