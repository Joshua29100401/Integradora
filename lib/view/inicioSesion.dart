import 'package:flutter/material.dart';
import 'package:integradora/view/provider.dart';
import 'package:provider/provider.dart';
import 'pagina_i.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true; // Controla si la contraseña está oculta o visible

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showMessage("Por favor, completa todos los campos.");
      return;
    }

    final provider = Provider.of<TransactionProvider>(context, listen: false);
    bool success = await provider.login(username, password, context);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PaginaInicio()),
      );
    } else {
      _showMessage("Usuario o contraseña incorrectos.");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(),
            const SizedBox(height: 40),
            _inputField(),
            const SizedBox(height: 10),
            _forgotPassword(),
            const SizedBox(height: 20),
            _loginButton(),
            const SizedBox(height: 20),
            _signup(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const Column(
      children: [
        Text(
          "Bienvenido a Mis manos hablarán",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text("Inicia sesión para continuar"),
      ],
    );
  }

  Widget _inputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField("Usuario", Icons.person, false, _usernameController),
        const SizedBox(height: 10),
        _buildTextField("Contraseña", Icons.lock, true, _passwordController),
      ],
    );
  }

  Widget _buildTextField(String hint, IconData icon, bool isPassword,
      TextEditingController controller) {
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
        prefixIcon: Icon(icon, color: Colors.purple),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.purple,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText =
                        !_obscureText; // Alterna el estado de visibilidad
                  });
                },
              )
            : null,
      ),
      obscureText: isPassword
          ? _obscureText
          : false, // Solo oculta el texto si es una contraseña
    );
  }

  Widget _forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          "¿Has olvidado tu constraseña?",
          style: TextStyle(color: Colors.purple),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.purple,
      ),
      child: const Text(
        "Iniciar Sesión",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget _signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿No tienes una cuenta?"),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/Registro');
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
