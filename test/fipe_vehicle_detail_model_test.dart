import 'package:flutter_test/flutter_test.dart';
import 'package:finalproject/models/fipe_models.dart';

void main() {
  group('FipeVehicleDetail model', () {
    test('fromJson deve mapear campos corretamente', () {
      final json = {
        'Valor': 'R\$ 50.000,00',
        'Marca': 'Audi',
        'Modelo': 'A3 1.8 Turbo',
        'AnoModelo': 2010,
        'Combustivel': 'Gasolina',
        'CodigoFipe': '008123-4',
        'MesReferencia': 'dezembro de 2025',
      };

      final detail = FipeVehicleDetail.fromJson(json);

      expect(detail.valor, 'R\$ 50.000,00');
      expect(detail.marca, 'Audi');
      expect(detail.modelo, 'A3 1.8 Turbo');
      expect(detail.anoModelo, 2010);
      expect(detail.combustivel, 'Gasolina');
      expect(detail.codigoFipe, '008123-4');
      expect(detail.mesReferencia, 'dezembro de 2025');
    });

    test('toJson deve gerar mapa compatível com API', () {
      final detail = FipeVehicleDetail(
        valor: 'R\$ 50.000,00',
        marca: 'Audi',
        modelo: 'A3 1.8 Turbo',
        anoModelo: 2010,
        combustivel: 'Gasolina',
        codigoFipe: '008123-4',
        mesReferencia: 'dezembro de 2025',
      );

      final json = detail.toJson();

      expect(json['Valor'], 'R\$ 50.000,00');
      expect(json['Marca'], 'Audi');
      expect(json['Modelo'], 'A3 1.8 Turbo');
      expect(json['AnoModelo'], 2010);
      expect(json['Combustivel'], 'Gasolina');
      expect(json['CodigoFipe'], '008123-4');
      expect(json['MesReferencia'], 'dezembro de 2025');
    });
  });
}
