import 'package:flutter_test/flutter_test.dart';
import 'package:trylevel3/main.dart';

void main() {
  testWidgets('la page d accueil affiche les emissions', (tester) async {
    await tester.pumpWidget(const MonApplication());
    expect(find.text('Vos émissions en streaming'), findsOneWidget);
    expect(find.text('Le Réveil'), findsOneWidget);
  });
}
