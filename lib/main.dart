import 'package:flutter/material.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(const BloodWankaApp());
}

class BloodWankaApp extends StatelessWidget {
  const BloodWankaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Wanka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFE21B4C), // Color rojo base de tus interfaces
        useMaterial3: true,
      ),
      // --- ESTE ES EL ÚNICO CAMBIO ---
      // Inicia directamente en la interfaz de Quispe Ortiz
      initialRoute: AppRoutes.login, 
      routes: AppRoutes.getRoutes(),
    );
  }
}