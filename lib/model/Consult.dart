class Consult {
  // final int id;
  // final int idUsuarioPac;
  // final int idUsuarioDoc;
  // final String titulo;
  // final String descripcion;
  // final String fecha;
  // final String precio;

  final int idconsulta;
  final String docname;
  final String pacname;
  final String precio;

  const Consult({
    // required this.id,
    // required this.idUsuarioPac,
    // required this.idUsuarioDoc,
    // required this.titulo,
    // required this.descripcion,
    // required this.fecha,
    // required this.precio
    required this.idconsulta,
    required this.docname,
    required this.pacname,
    required this.precio
  });

  factory Consult.fromJson(Map<String, dynamic> json) {
    return Consult(
      idconsulta : json['idconsulta'],
      docname : json['docname'],
      pacname : json['pacname'],
      precio : json['precio'],
    );
  }
}