import 'package:flutter/material.dart';

import '../../core/widgets/polka_dot_background.dart';
import '../../core/theme/app_theme.dart';
import '../catalog/catalog_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PolkaDotBackground(
        showBottomGradient: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Container(
                  height: 230,
                  width: 230,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(54),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Image.asset(
                    'assets/images/regalo_azul.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.card_giftcard,
                      size: 130,
                      color: AppColors.navy,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Detalles que cuentan historias',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 28,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(flex: 2),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const CatalogScreen(),
                        ),
                      );
                    },
                    child: const Text('COMENZAR'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
