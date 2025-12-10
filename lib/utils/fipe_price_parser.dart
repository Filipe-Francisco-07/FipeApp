double parseFipePrice(String valor) {
  var cleaned = valor.replaceAll('R\$', '');
  cleaned = cleaned.replaceAll('.', '');
  cleaned = cleaned.replaceAll(' ', '');
  cleaned = cleaned.replaceAll(',', '.');

  return double.tryParse(cleaned) ?? 0.0;
}
