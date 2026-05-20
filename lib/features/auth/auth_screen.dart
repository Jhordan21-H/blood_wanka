import 'package:flutter/material.dart';

/// =======================================================================
/// ÁREA DE TRABAJO EXCLUSIVA PARA: [Nombre del Compañero 3]
/// RAMA SUGERIDA EN GIT: feature/auth
/// 
/// INSTRUCCIONES IMPORTANTES PARA EL EQUIPO:
/// 1. Trabaja todo el diseño de Autenticación dentro de este archivo.
/// 2. Si necesitas crear componentes extra, crea una carpeta llamada 
///    `widgets` dentro de tu carpeta `auth/`.
/// 3. ¡POR FAVOR NO MODIFIQUES! ni `main.dart` ni `app_routes.dart`.
/// 4. Para usar el color rojo oficial de Blood Wanka, NO lo escribas a mano. 
///    Utiliza: Theme.of(context).primaryColor
/// =======================================================================

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Interfaz de Autenticación ([Macha Pariona)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}