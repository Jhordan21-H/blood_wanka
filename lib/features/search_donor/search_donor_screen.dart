import 'package:flutter/material.dart';

/// =======================================================================
/// ÁREA DE TRABAJO EXCLUSIVA PARA: [Nombre del Compañero 4]
/// RAMA SUGERIDA EN GIT: feature/search_donor
/// 
/// INSTRUCCIONES IMPORTANTES PARA EL EQUIPO:
/// 1. Trabaja todo el diseño de Búsqueda de Donadores en este archivo.
/// 2. Si necesitas crear componentes extra (ej. el pin del mapa), crea una 
///    carpeta llamada `widgets` dentro de tu carpeta `search_donor/`.
/// 3. ¡POR FAVOR NO MODIFIQUES! ni `main.dart` ni `app_routes.dart`.
/// 4. Los botones elevados (ElevatedButton) y las cajas de texto (TextField) 
///    ya tienen el estilo global configurado por defecto.
/// =======================================================================

class SearchDonorScreen extends StatelessWidget {
  const SearchDonorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Buscar Donante (Janampa)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}