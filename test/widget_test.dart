import 'package:flutter_test/flutter_test.dart';
import 'package:immersive_street/main.dart';
import 'package:provider/provider.dart';
import 'package:immersive_street/application/services/transition_service.dart';
import 'package:immersive_street/application/use_cases/enter_street_view.dart';

void main() {
  testWidgets('Smoke test: can see Map View Placeholder and button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TransitionService()),
          ProxyProvider<TransitionService, EnterStreetView>(
            update: (context, service, previous) => EnterStreetView(service),
          ),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.text('2D Map View Placeholder'), findsOneWidget);
    expect(find.text('Enter Street View'), findsOneWidget);
  });
}
