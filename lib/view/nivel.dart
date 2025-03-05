class Nivel {
  final int id;
  final String nombre;
  final String descripcion;
  bool estado; // Cambiar a variable mutable
  final String imagenUrl; // Nueva propiedad para la URL de la imagen

  Nivel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    required this.imagenUrl, // Incluir en el constructor
  });

  factory Nivel.fromJson(Map<String, dynamic> json) {
    return Nivel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'] == 1,
      imagenUrl: json['imagen_url'] ?? '', // Cargar URL
    );
  }

  void toggleEstado() {
    estado = !estado;
  }
}
