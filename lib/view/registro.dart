import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _signup() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage("Todos los campos son obligatorios", isError: true);
      return;
    }

    if (password != confirmPassword) {
      _showMessage("Las contraseñas no coinciden", isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await supabase.from('usuarios').insert({
        'nombre_usuario': name,
        'email': email,
        'contraseña': password,
        'fecha_registro': DateTime.now().toIso8601String(),
      });

      _showMessage("Registro exitoso", isError: false);
      Navigator.pushReplacementNamed(context, '/inicioS');
    } catch (e) {
      _showMessage("Error: ${e.toString()}", isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 60.0),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildInputFields(),
              const SizedBox(height: 20),
              _buildSignupButton(),
              const SizedBox(height: 20),
              _buildLoginOption(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text("Sign up",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("Crear tu cuenta",
            style: TextStyle(fontSize: 15, color: Colors.grey)),
      ],
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        _buildTextField("Usuario", Icons.person, _nameController),
        const SizedBox(height: 15),
        _buildTextField("Correo", Icons.email, _emailController),
        const SizedBox(height: 15),
        _buildPasswordField(
            "Contraseña", _passwordController, _isPasswordVisible, () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        }),
        const SizedBox(height: 15),
        _buildPasswordField("Confirmar contraseña", _confirmPasswordController,
            _isConfirmPasswordVisible, () {
          setState(() {
            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
          });
        }),
      ],
    );
  }

  Widget _buildTextField(
      String hint, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.purple.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _buildPasswordField(String hint, TextEditingController controller,
      bool isVisible, VoidCallback toggleVisibility) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.purple.withOpacity(0.1),
        filled: true,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
        ),
      ),
      obscureText: !isVisible,
    );
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _signup,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.purple,
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("Registrarse",
              style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }

  Widget _buildLoginOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿Ya tienes una cuenta?"),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/inicioS');
          },
          child: const Text("Ingresar", style: TextStyle(color: Colors.purple)),
        ),
      ],
    );
  }
}
