import 'package:flutter/material.dart';

/// =======================================================================
/// ÁREA DE TRABAJO EXCLUSIVA PARA: Jhordan Armando Huaman Rojas
/// RAMA SUGERIDA EN GIT: feature/home
/// 
/// INSTRUCCIONES IMPORTANTES PARA EL EQUIPO:
/// 1. Trabaja todo el diseño de la Pantalla Principal dentro de este archivo.
/// 2. Si necesitas crear componentes extra (ej. tarjetas de información), 
///    crea una carpeta llamada `widgets` dentro de tu carpeta `home/`.
/// 3. ¡POR FAVOR NO MODIFIQUES! ni `main.dart` ni `app_routes.dart`.
/// 4. Los botones elevados (ElevatedButton) y las cajas de texto (TextField) 
///    ya tienen el estilo global configurado por defecto.
/// =======================================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Página Principal (Huaman Rojas)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}