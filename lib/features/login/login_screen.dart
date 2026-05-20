import 'package:flutter/material.dart';

/// =======================================================================
/// ÁREA DE TRABAJO EXCLUSIVA PARA: Quispe Ortiz
/// RAMA SUGERIDA EN GIT: feature/login
/// 
/// INSTRUCCIONES IMPORTANTES PARA EL EQUIPO:
/// 1. Trabaja todo el diseño del Login dentro de este archivo.
/// 2. Si necesitas crear componentes extra (ej. un botón especial), 
///    crea una carpeta llamada `widgets` dentro de tu carpeta `login/`.
/// 3. ¡POR FAVOR NO MODIFIQUES! ni `main.dart` ni `app_routes.dart`.
/// 4. Para usar el color rojo oficial de Blood Wanka, NO lo escribas a mano. 
///    Utiliza: Theme.of(context).primaryColor
/// =======================================================================

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Interfaz de Login (Quispe Ortiz)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}