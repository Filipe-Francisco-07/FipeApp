import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finalproject/screens/home_screen.dart';

void main() {
  testWidgets('Home deve exibir as três opções principais',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Consultar preço FIPE'), findsOneWidget);
    expect(find.text('Minha Garagem (PC)'), findsOneWidget);
    expect(find.text('Comparar veículos'), findsOneWidget);
  });
}
