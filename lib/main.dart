import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'application/services/transition_service.dart';
import 'application/use_cases/enter_street_view.dart';
import 'presentation/widgets/immersive_street_view.dart';
import 'presentation/widgets/transition_overlay.dart';

void main() {
  runApp(
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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Twin Immersive Street',
      theme: ThemeData.dark(),
      home: const MapPlaceholderPage(),
    );
  }
}

class MapPlaceholderPage extends StatelessWidget {
  const MapPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transitionService = context.watch<TransitionService>();
    final enterStreetView = context.read<EnterStreetView>();

    return Scaffold(
      body: TransitionOverlay(
        active: transitionService.showBlur,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.map, size: 100, color: Colors.grey),
              const SizedBox(height: 20),
              const Text("2D Map View Placeholder"),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  await enterStreetView.execute(37.7749, -122.4194);
                  if (context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ImmersiveStreetView(
                          initialLat: 37.7749,
                          initialLon: -122.4194,
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Enter Street View"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
