import 'package:flutter/material.dart';

/// =======================================================================
/// AREA DE TRABAJO EXCLUSIVA PARA: Janampa
/// RAMA SUGERIDA EN GIT: feature/search_donor
///
/// INSTRUCCIONES IMPORTANTES PARA EL EQUIPO:
/// 1. Trabaja todo el diseno de Busqueda de Donadores en este archivo.
/// 2. Si necesitas crear componentes extra (ej. el pin del mapa), crea una
///    carpeta llamada `widgets` dentro de tu carpeta `search_donor/`.
/// 3. POR FAVOR NO MODIFIQUES ni `main.dart` ni `app_routes.dart`.
/// 4. Los botones elevados (ElevatedButton) y las cajas de texto (TextField)
///    ya tienen el estilo global configurado por defecto.
/// =======================================================================

class SearchDonorScreen extends StatefulWidget {
  const SearchDonorScreen({super.key});

  @override
  State<SearchDonorScreen> createState() => _SearchDonorScreenState();
}

class _SearchDonorScreenState extends State<SearchDonorScreen> {
  final TextEditingController _locationController = TextEditingController(
    text: 'Huancayo',
  );

  final List<String> _bloodTypes = const [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  final List<String> _institutions = const [
    'Hospital Carrion',
    'Hospital El Carmen',
    'Clinica Ortega',
    'EsSalud Huancayo',
  ];

  final List<_Donor> _donors = const [
    _Donor(
      name: 'Luis Mendoza',
      bloodType: 'O+',
      district: 'El Tambo',
      minutesAway: 8,
      availability: 'Disponible ahora',
      donations: 5,
      verified: true,
    ),
    _Donor(
      name: 'Rosa Huaman',
      bloodType: 'A+',
      district: 'Huancayo',
      minutesAway: 12,
      availability: 'Disponible en 30 min',
      donations: 3,
      verified: true,
    ),
    _Donor(
      name: 'Carlos Janampa',
      bloodType: 'O-',
      district: 'Chilca',
      minutesAway: 18,
      availability: 'Confirmar por llamada',
      donations: 7,
      verified: false,
    ),
  ];

  String _selectedBloodType = 'O+';
  String _selectedInstitution = 'Hospital Carrion';
  bool _urgentOnly = true;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Buscar Donante'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            _HeaderCard(primaryColor: primaryColor),
            const SizedBox(height: 16),
            _SectionTitle(
              icon: Icons.tune,
              title: 'Filtros de busqueda',
              color: primaryColor,
            ),
            const SizedBox(height: 10),
            _SearchPanel(
              primaryColor: primaryColor,
              locationController: _locationController,
              bloodTypes: _bloodTypes,
              selectedBloodType: _selectedBloodType,
              institutions: _institutions,
              selectedInstitution: _selectedInstitution,
              urgentOnly: _urgentOnly,
              onBloodTypeChanged: (value) {
                setState(() => _selectedBloodType = value);
              },
              onInstitutionChanged: (value) {
                setState(() => _selectedInstitution = value);
              },
              onUrgentChanged: (value) {
                setState(() => _urgentOnly = value);
              },
            ),
            const SizedBox(height: 16),
            _MapPreview(primaryColor: primaryColor),
            const SizedBox(height: 16),
            _SectionTitle(
              icon: Icons.volunteer_activism,
              title: 'Donantes cercanos',
              color: primaryColor,
            ),
            const SizedBox(height: 10),
            ..._donors.map(
              (donor) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _DonorCard(donor: donor, primaryColor: primaryColor),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Solicitud enviada a donantes $_selectedBloodType cerca de ${_locationController.text}.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.search),
            label: const Text('Buscar donantes disponibles'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.primaryColor});

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Icon(Icons.bloodtype, size: 34, color: primaryColor),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Encuentra sangre compatible',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Filtra por grupo sanguineo, hospital y ubicacion cercana.',
                  style: TextStyle(color: Colors.white70, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchPanel extends StatelessWidget {
  const _SearchPanel({
    required this.primaryColor,
    required this.locationController,
    required this.bloodTypes,
    required this.selectedBloodType,
    required this.institutions,
    required this.selectedInstitution,
    required this.urgentOnly,
    required this.onBloodTypeChanged,
    required this.onInstitutionChanged,
    required this.onUrgentChanged,
  });

  final Color primaryColor;
  final TextEditingController locationController;
  final List<String> bloodTypes;
  final String selectedBloodType;
  final List<String> institutions;
  final String selectedInstitution;
  final bool urgentOnly;
  final ValueChanged<String> onBloodTypeChanged;
  final ValueChanged<String> onInstitutionChanged;
  final ValueChanged<bool> onUrgentChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: locationController,
            decoration: const InputDecoration(
              labelText: 'Distrito o ciudad',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: selectedInstitution,
            items: institutions
                .map(
                  (institution) => DropdownMenuItem(
                    value: institution,
                    child: Text(institution),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) onInstitutionChanged(value);
            },
            decoration: const InputDecoration(
              labelText: 'Institucion medica',
              prefixIcon: Icon(Icons.local_hospital_outlined),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Grupo sanguineo requerido',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: bloodTypes.map((type) {
              final isSelected = type == selectedBloodType;

              return ChoiceChip(
                label: Text(type),
                selected: isSelected,
                selectedColor: primaryColor,
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
                onSelected: (_) => onBloodTypeChanged(type),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: urgentOnly,
            activeThumbColor: primaryColor,
            title: const Text(
              'Caso urgente',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: const Text('Priorizar donantes disponibles ahora'),
            onChanged: onUrgentChanged,
          ),
        ],
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview({required this.primaryColor});

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _MapGridPainter(color: Colors.grey.shade300),
            ),
          ),
          Positioned(
            left: 28,
            top: 30,
            child: _MapPin(color: primaryColor, label: 'O+'),
          ),
          Positioned(
            right: 34,
            top: 22,
            child: _MapPin(color: Colors.blueGrey, label: 'A+'),
          ),
          Positioned(
            left: 118,
            bottom: 24,
            child: _MapPin(color: Colors.green, label: 'O-'),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    'Radio de busqueda: 5 km',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DonorCard extends StatelessWidget {
  const _DonorCard({required this.donor, required this.primaryColor});

  final _Donor donor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: primaryColor.withValues(alpha: 0.10),
            child: Text(
              donor.bloodType,
              style: TextStyle(
                color: primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        donor.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (donor.verified) ...[
                      const SizedBox(width: 6),
                      Icon(Icons.verified, size: 18, color: primaryColor),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${donor.district} - ${donor.minutesAway} min',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                Text(
                  '${donor.availability} - ${donor.donations} donaciones',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Contactar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Contactando a ${donor.name}...')),
              );
            },
            icon: Icon(Icons.phone_in_talk, color: primaryColor),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Icon(Icons.location_pin, color: color, size: 30),
      ],
    );
  }
}

class _MapGridPainter extends CustomPainter {
  const _MapGridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    for (double x = 24; x < size.width; x += 48) {
      canvas.drawLine(Offset(x, 0), Offset(x + 28, size.height), paint);
    }

    for (double y = 22; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y - 16), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MapGridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _Donor {
  const _Donor({
    required this.name,
    required this.bloodType,
    required this.district,
    required this.minutesAway,
    required this.availability,
    required this.donations,
    required this.verified,
  });

  final String name;
  final String bloodType;
  final String district;
  final int minutesAway;
  final String availability;
  final int donations;
  final bool verified;
}
