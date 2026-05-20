import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class DevMenuScreen extends StatelessWidget {
  const DevMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blood Wanka - Dev Menu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( // <--- Aquí estaba el error (decía body en lugar de child)
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Selecciona tu interfaz para trabajar:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              child: const Text('Ir a Login (Quispe Ortiz)'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.auth),
              child: const Text('Ir a Autenticación (Macha Pariona)'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.homePage),
              child: const Text('Ir a Página Principal (Huaman Rojas)'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.searchDonor),
              child: const Text('Ir a Buscar Donante (Janampa)'),
            ),
          ],
        ),
      ),
    );
  }
}