class User {
  final int id;
  final String usuario;
  final String contrasenia;
  final String nombre;
  final String apellido;
  final String direccion;
  final String telefono;
  final int idTipoUsuario;

  const User({
    required this.id,
    required this.usuario,
    required this.contrasenia,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.telefono,
    required this.idTipoUsuario
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id : json['id'],
      usuario : json['usuario'],
      contrasenia : json['contrasenia'],
      nombre : json['nombre'],
      apellido : json['apellido'],
      direccion : json['direccion'],
      telefono : json['telefono'],
      idTipoUsuario : json['idTipoUsuario']
    );
  }
}