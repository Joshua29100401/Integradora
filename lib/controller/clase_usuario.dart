class UserModel {
  final String id;
  final String nombreUsuario;
  final String email;

  UserModel({
    required this.id,
    required this.nombreUsuario,
    required this.email,
  });

  // Método para convertir de JSON a UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      nombreUsuario: json['nombre_usuario'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // Método para convertir UserModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre_usuario': nombreUsuario,
      'email': email,
    };
  }
}
