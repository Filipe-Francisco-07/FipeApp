double parseFipePrice(String valor) {
  // Exemplo de valor: "R$ 193.758,00"
  var cleaned = valor.replaceAll('R\$', '');
  cleaned = cleaned.replaceAll('.', '');
  cleaned = cleaned.replaceAll(' ', '');
  cleaned = cleaned.replaceAll(',', '.');

  return double.tryParse(cleaned) ?? 0.0;
}
