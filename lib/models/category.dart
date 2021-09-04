import 'dart:convert';

class Category {
  Category({
    required this.id,
    required this.nombre,
    required this.usuario,
  });

  String id;
  String nombre;
  _User usuario;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["_id"],
        nombre: json["nombre"],
        usuario: _User.fromMap(json["usuario"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "usuario": usuario.toMap(),
      };

  @override
  String toString() {
    return 'Category: ${this.nombre}';
  }
}

class _User {
  _User({
    required this.id,
    required this.nombre,
  });

  String id;
  String nombre;

  //factory _User.fromJson(String str) => _User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _User.fromMap(Map<String, dynamic> json) => _User(
        id: json["_id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
      };
}
