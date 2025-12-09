import 'package:flutter_test/flutter_test.dart';
import 'package:finalproject/utils/fipe_price_parser.dart';

void main() {
  group('parseFipePrice', () {
    test('deve converter valor no formato brasileiro corretamente', () {
      final result = parseFipePrice('R\$ 193.758,00');
      expect(result, closeTo(193758.00, 0.01));
    });

    test('deve retornar 0.0 para valores inválidos', () {
      final result = parseFipePrice('valor inválido');
      expect(result, 0.0);
    });
  });
}
