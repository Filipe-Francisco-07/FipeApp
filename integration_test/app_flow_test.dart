import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:finalproject/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste: Splash Home',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AutoInsightFipeApp());

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Consultar preço FIPE'), findsOneWidget);
    expect(find.text('Minha Garagem (PC)'), findsOneWidget);
  });
}
