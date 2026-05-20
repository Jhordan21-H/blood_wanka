import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// Importamos los widgets globales que creaste
import '../../core/widgets/custom_drawer.dart';
import '../../core/widgets/custom_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      // ESTO ES LO QUE HACE QUE EL MENÚ HAMBURGUESA SE ABRA:
      drawer: const CustomDrawer(), 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ESTO LLAMA A TU BUSCADOR GLOBAL:
            const CustomSearchBar(hintText: 'Buscar donantes o centros...'),
            const SizedBox(height: 25),
            
            // ESTO LLAMA AL MAPA REAL (Ya no al placeholder):
            _buildRealMap(),
            
            const SizedBox(height: 30),
            _buildSectionHeader(primaryColor),
            const SizedBox(height: 15),
            _buildDonorCard(primaryColor),
          ],
        ),
      ),
    );
  }

  // --- COMPONENTE DEL MAPA REAL ---
  Widget _buildRealMap() {
    return Container(
      height: 180, 
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(-12.0651, -75.2048), // Coordenadas de Huancayo
            initialZoom: 14.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.blood_wanka',
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(-12.0651, -75.2048),
                  width: 40,
                  height: 40,
                  child: Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Buscador de sangre',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'ver todo',
            style: TextStyle(color: primaryColor, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDonorCard(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  'A+',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Balvin Marcos',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'texto texto texto texto texto texto texto texto',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: primaryColor, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    'Huancayo-El Tambo',
                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text('Donar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}