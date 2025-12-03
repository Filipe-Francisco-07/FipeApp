class FipeBrand {
  final String codigo;
  final String nome;

  FipeBrand({
    required this.codigo,
    required this.nome,
  });

  factory FipeBrand.fromJson(Map<String, dynamic> json) {
    return FipeBrand(
      codigo: json['codigo'].toString(),
      nome: json['nome'] as String,
    );
  }
}

class FipeModel {
  final String codigo;
  final String nome;

  FipeModel({
    required this.codigo,
    required this.nome,
  });

  factory FipeModel.fromJson(Map<String, dynamic> json) {
    return FipeModel(
      codigo: json['codigo'].toString(),
      nome: json['nome'] as String,
    );
  }
}

class FipeYear {
  final String codigo;
  final String nome;

  FipeYear({
    required this.codigo,
    required this.nome,
  });

  factory FipeYear.fromJson(Map<String, dynamic> json) {
    return FipeYear(
      codigo: json['codigo'].toString(),
      nome: json['nome'] as String,
    );
  }
}

class FipeVehicleDetail {
  final String valor;
  final String marca;
  final String modelo;
  final int anoModelo;
  final String combustivel;
  final String codigoFipe;
  final String mesReferencia;

  FipeVehicleDetail({
    required this.valor,
    required this.marca,
    required this.modelo,
    required this.anoModelo,
    required this.combustivel,
    required this.codigoFipe,
    required this.mesReferencia,
  });

  factory FipeVehicleDetail.fromJson(Map<String, dynamic> json) {
    return FipeVehicleDetail(
      valor: json['Valor'] as String,
      marca: json['Marca'] as String,
      modelo: json['Modelo'] as String,
      anoModelo: json['AnoModelo'] as int,
      combustivel: json['Combustivel'] as String,
      codigoFipe: json['CodigoFipe'] as String,
      mesReferencia: json['MesReferencia'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Valor': valor,
      'Marca': marca,
      'Modelo': modelo,
      'AnoModelo': anoModelo,
      'Combustivel': combustivel,
      'CodigoFipe': codigoFipe,
      'MesReferencia': mesReferencia,
    };
  }

}
