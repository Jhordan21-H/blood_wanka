import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: primaryColor),
            accountName: const Text('Usuario Blood Wanka'),
            accountEmail: const Text('usuario@email.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () { // <-- Cambiado de onPressed a onTap
              Navigator.pop(context); 
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Buscar Donante'),
            onTap: () { // <-- Cambiado de onPressed a onTap
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.searchDonor);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mi Perfil'),
            onTap: () {}, // <-- Cambiado de onPressed a onTap
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
            onTap: () { // <-- Cambiado de onPressed a onTap
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }
}