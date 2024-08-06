class TrenModel {
  final String? id;
  final String modelo;
  final String fabricante;
  final double longuitud;
  final double capacidad;

  TrenModel({
    this.id,
    required this.modelo,
    required this.fabricante,
    required this.longuitud,
    required this.capacidad,
  });

  factory TrenModel.fromJson(Map<String, dynamic> json) {
    return TrenModel(
      id: json['id'],
      modelo: json['modelo'],
      fabricante: json['fabricante'],
      longuitud: json['longuitud'],
      capacidad: json['capacidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelo': modelo,
      'fabricante': fabricante,
      'longuitud': longuitud,
      'capacidad': capacidad,
    };
  }
}
