import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;
  String searchText = '';
  String selectedBlood = 'Todos';
  String selectedZone = 'Todas';

  final List<Map<String, dynamic>> donors = [
    {
      'name': 'Balvin Marcos',
      'blood': 'O+',
      'zone': 'El Tambo',
      'distance': '1.2 km',
      'status': 'Disponible',
      'description': 'Puede donar hoy cerca del Hospital Carrión.',
      'image': 'assets/images/perfiles/balvin.png',
      'online': true,
      'favorite': true,
    },
    {
      'name': 'Gianela Vargas',
      'blood': 'A+',
      'zone': 'Huancayo',
      'distance': '2.0 km',
      'status': 'Disponible',
      'description': 'Donante activa y disponible por la tarde.',
      'image': 'assets/images/perfiles/gianela.png',
      'online': true,
      'favorite': false,
    },
    {
      'name': 'María Rojas',
      'blood': 'B+',
      'zone': 'Chilca',
      'distance': '3.5 km',
      'status': 'Mañana',
      'description': 'Puede donar mañana por la mañana.',
      'image': 'assets/images/perfiles/maria.png',
      'online': false,
      'favorite': true,
    },
    {
      'name': 'Lucía Pérez',
      'blood': 'A-',
      'zone': 'Concepción',
      'distance': '8.1 km',
      'status': 'Disponible',
      'description': 'Registrada como donante voluntaria.',
      'image': 'assets/images/perfiles/lucia.png',
      'online': false,
      'favorite': false,
    },
    {
      'name': 'José Antonio',
      'blood': 'O-',
      'zone': 'San Ramón',
      'distance': '12 km',
      'status': 'No disponible',
      'description': 'Podrá donar la siguiente semana.',
      'image': 'assets/images/perfiles/jose.png',
      'online': true,
      'favorite': false,
    },
  ];

  final List<Map<String, dynamic>> alerts = [
    {
      'title': 'Solicitud urgente',
      'message': 'Paciente necesita sangre O+ cerca del Hospital Carrión.',
      'time': 'Hace 5 min',
      'icon': Icons.emergency,
    },
    {
      'title': 'Nuevo donante',
      'message': 'Balvin Marcos está disponible en El Tambo.',
      'time': 'Hace 15 min',
      'icon': Icons.person_add,
    },
    {
      'title': 'Banco activo',
      'message': 'Hospital Carrión tiene atención disponible.',
      'time': 'Hace 30 min',
      'icon': Icons.local_hospital,
    },
  ];

  List<Map<String, dynamic>> get filteredDonors {
    return donors.where((donor) {
      final search = searchText.toLowerCase();
      final name = donor['name'].toString().toLowerCase();
      final blood = donor['blood'].toString().toLowerCase();
      final zone = donor['zone'].toString().toLowerCase();
      final status = donor['status'].toString().toLowerCase();

      final matchSearch = name.contains(search) ||
          blood.contains(search) ||
          zone.contains(search) ||
          status.contains(search);

      final matchBlood =
          selectedBlood == 'Todos' || donor['blood'] == selectedBlood;

      final matchZone = selectedZone == 'Todas' || donor['zone'] == selectedZone;

      return matchSearch && matchBlood && matchZone;
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4F8),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
              children: [
                _topBar(primary),
                const SizedBox(height: 16),
                _searchBar(primary),
                const SizedBox(height: 18),
                _heroMapCard(primary),
                const SizedBox(height: 18),
                _urgentCard(primary),
                const SizedBox(height: 18),
                _statsRow(primary),
                const SizedBox(height: 22),
                _sectionHeader(primary),
                const SizedBox(height: 12),
                if (filteredDonors.isEmpty)
                  _emptyState()
                else
                  ...filteredDonors.map((donor) => _donorCard(donor, primary)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomBar(primary),
    );
  }

  Widget _topBar(Color primary) {
    final unreadAlerts = alerts.length;

    return Row(
      children: [
        InkWell(
          onTap: _showMainMenu,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.menu, color: Colors.black87),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Página principal',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Encuentra donantes cercanos',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: _showAlerts,
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.notifications_none, color: primary),
              ),
              Positioned(
                right: -3,
                top: -4,
                child: CircleAvatar(
                  radius: 9,
                  backgroundColor: primary,
                  child: Text(
                    unreadAlerts.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchBar(Color primary) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Buscar donante, sangre o zona...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchText.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          searchText = '';
                        });
                      },
                      icon: const Icon(Icons.close),
                    ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          onTap: _showFilters,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.28),
                  blurRadius: 14,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _heroMapCard(Color primary) {
    return Container(
      height: 205,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: CustomPaint(
                painter: _MapPainter(primary),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: primary, size: 18),
                  const SizedBox(width: 6),
                  const Text(
                    'Huancayo - El Tambo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: ElevatedButton.icon(
              onPressed: _showMapInfo,
              icon: const Icon(Icons.map),
              label: const Text('Ver mapa'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _urgentCard(Color primary) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primary,
            primary.withOpacity(0.78),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bloodtype,
              color: Colors.white,
              size: 34,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Solicitud urgente O+',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Paciente necesita donante cerca del Hospital Carrión.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: _showEmergencyRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Atender ahora'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsRow(Color primary) {
    return Row(
      children: [
        _statCard(primary, '24', 'Donantes', Icons.people_alt),
        const SizedBox(width: 10),
        _statCard(primary, '8', 'Urgentes', Icons.warning_amber),
        const SizedBox(width: 10),
        _statCard(primary, '5', 'Bancos', Icons.local_hospital),
      ],
    );
  }

  Widget _statCard(Color primary, String number, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: primary),
            const SizedBox(height: 7),
            Text(
              number,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(Color primary) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Buscador de sangre',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
        ),
        TextButton(
          onPressed: _goToSearchDonor,
          child: Text(
            'ver todo',
            style: TextStyle(color: primary),
          ),
        ),
      ],
    );
  }

  Widget _donorCard(Map<String, dynamic> donor, Color primary) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 350),
      tween: Tween(begin: 0.92, end: 1),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.055),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            _ProfileAvatar(
              image: donor['image'],
              radius: 34,
              online: donor['online'],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          donor['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            donor['favorite'] = !donor['favorite'];
                          });
                        },
                        child: Icon(
                          donor['favorite'] ? Icons.star : Icons.star_border,
                          color: donor['favorite'] ? primary : Colors.black38,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    donor['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 7,
                    runSpacing: 6,
                    children: [
                      _miniTag(Icons.location_on, donor['zone']),
                      _miniTag(Icons.social_distance, donor['distance']),
                      _miniTag(Icons.access_time, donor['status']),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                _bloodBadge(donor['blood'], primary),
                const SizedBox(height: 9),
                SizedBox(
                  height: 34,
                  child: ElevatedButton(
                    onPressed: () => _showDonorDetail(donor),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Ver',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.black54),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _bloodBadge(String blood, Color primary) {
    return Container(
      height: 44,
      width: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        blood,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          Icon(Icons.search_off, size: 46, color: Colors.black38),
          SizedBox(height: 10),
          Text(
            'No se encontraron donantes',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Intenta cambiar los filtros de búsqueda.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar(Color primary) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: primary,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            setState(() {
              selectedIndex = 0;
            });
          } else if (index == 1) {
            _showProfile();
          } else if (index == 2) {
            _goToChat();
          } else if (index == 3) {
            _showAlerts();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Conversaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            activeIcon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
        ],
      ),
    );
  }

  void _showFilters() {
    final primary = Theme.of(context).primaryColor;

    String tempBlood = selectedBlood;
    String tempZone = selectedZone;

    final bloodTypes = [
      'Todos',
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-',
    ];

    final zones = [
      'Todas',
      'Huancayo',
      'El Tambo',
      'Chilca',
      'Concepción',
      'San Ramón',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFF4F8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.74,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 10),
                      child: Column(
                        children: [
                          Container(
                            height: 5,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Filtros de búsqueda',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tipo de sangre',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: bloodTypes.map((blood) {
                                final selected = tempBlood == blood;

                                return ChoiceChip(
                                  label: Text(blood),
                                  selected: selected,
                                  selectedColor: primary,
                                  labelStyle: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onSelected: (_) {
                                    modalSetState(() {
                                      tempBlood = blood;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 22),
                            const Text(
                              'Ubicación',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            ...zones.map((zone) {
                              final selected = tempZone == zone;

                              return _filterOption(
                                primary: primary,
                                icon: Icons.location_on_outlined,
                                text: zone,
                                selected: selected,
                                onTap: () {
                                  modalSetState(() {
                                    tempZone = zone;
                                  });
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(22, 10, 22, 18),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                modalSetState(() {
                                  tempBlood = 'Todos';
                                  tempZone = 'Todas';
                                });
                              },
                              child: const Text('Limpiar'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedBlood = tempBlood;
                                  selectedZone = tempZone;
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Aplicar filtros'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _filterOption({
    required Color primary,
    required IconData icon,
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? primary.withOpacity(0.08) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? primary : Colors.black12,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: selected ? primary : Colors.black54, size: 20),
              const SizedBox(width: 12),
              Expanded(child: Text(text)),
              if (selected) Icon(Icons.check_circle, color: primary, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showDonorDetail(Map<String, dynamic> donor) {
    final primary = Theme.of(context).primaryColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFFF4F8),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 22),
                _ProfileAvatar(
                  image: donor['image'],
                  radius: 55,
                  online: donor['online'],
                ),
                const SizedBox(height: 14),
                Text(
                  donor['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                Text(
                  donor['status'],
                  style: TextStyle(
                    color: donor['status'] == 'Disponible'
                        ? Colors.green
                        : Colors.black54,
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      _detailRow(Icons.bloodtype, 'Tipo de sangre', donor['blood']),
                      _detailRow(Icons.location_on, 'Ubicación', donor['zone']),
                      _detailRow(Icons.social_distance, 'Distancia', donor['distance']),
                      _detailRow(Icons.info, 'Estado', donor['status']),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  donor['description'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        label: const Text('Cerrar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _sendRequest(donor);
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('Solicitar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(IconData icon, String title, String value) {
    final primary = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: primary.withOpacity(0.12),
            child: Icon(icon, color: primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _sendRequest(Map<String, dynamic> donor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Solicitud enviada a ${donor['name']}'),
      ),
    );
  }

  void _showEmergencyRequest() {
    final primary = Theme.of(context).primaryColor;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Solicitud urgente'),
        content: const Text(
          'Se notificará a los donantes O+ disponibles cerca del Hospital Carrión.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primary),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Alerta urgente enviada a donantes cercanos'),
                ),
              );
            },
            child: const Text('Enviar alerta'),
          ),
        ],
      ),
    );
  }

  void _showProfile() {
    final primary = Theme.of(context).primaryColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFFF4F8),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ProfileAvatar(
                  image: 'assets/images/perfiles/jose.png',
                  radius: 55,
                  online: true,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Jhordan Armando',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const Text(
                  'Módulo Página Principal',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),
                _detailRow(Icons.bloodtype, 'Grupo sanguíneo', 'O+'),
                _detailRow(Icons.location_on, 'Ubicación', 'Huancayo'),
                _detailRow(Icons.favorite, 'Donaciones', '5 registradas'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  child: const Text('Cerrar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAlerts() {
    final primary = Theme.of(context).primaryColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFFF4F8),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Notificaciones',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
                const SizedBox(height: 16),
                ...alerts.map((alert) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: primary,
                          child: Icon(alert['icon'], color: Colors.white),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                alert['message'],
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          alert['time'],
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMapInfo() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFFF4F8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.map, size: 60),
                SizedBox(height: 12),
                Text(
                  'Mapa de donantes cercanos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(height: 8),
                Text(
                  'Vista referencial de donantes y hospitales cercanos a Huancayo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMainMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFFF4F8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Menú principal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
                const SizedBox(height: 14),
                _menuTile(Icons.home, 'Inicio', () => Navigator.pop(context)),
                _menuTile(Icons.search, 'Buscar donantes', () {
                  Navigator.pop(context);
                  _showFilters();
                }),
                _menuTile(Icons.notifications, 'Alertas', () {
                  Navigator.pop(context);
                  _showAlerts();
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _menuTile(IconData icon, String text, VoidCallback onTap) {
    final primary = Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: Icon(icon, color: primary),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _goToSearchDonor() {
    Navigator.pushNamed(context, '/search-donor');
  }

  void _goToChat() {
    Navigator.pushNamed(context, '/chat');
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String image;
  final double radius;
  final bool online;

  const _ProfileAvatar({
    required this.image,
    required this.radius,
    required this.online,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Stack(
      children: [
        ClipOval(
          child: Image.asset(
            image,
            width: radius * 2,
            height: radius * 2,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: radius * 2,
                height: radius * 2,
                color: primary.withOpacity(0.15),
                child: Icon(Icons.person, color: primary, size: radius),
              );
            },
          ),
        ),
        if (online)
          Positioned(
            right: 1,
            bottom: 1,
            child: Container(
              height: 13,
              width: 13,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

class _MapPainter extends CustomPainter {
  final Color primary;

  _MapPainter(this.primary);

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFFF9FAFB);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), background);

    final roadPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final smallRoadPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(20, size.height * 0.28),
      Offset(size.width - 20, size.height * 0.18),
      roadPaint,
    );

    canvas.drawLine(
      Offset(30, size.height * 0.70),
      Offset(size.width - 35, size.height * 0.78),
      roadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.25, 20),
      Offset(size.width * 0.35, size.height - 20),
      smallRoadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.67, 20),
      Offset(size.width * 0.55, size.height - 20),
      smallRoadPaint,
    );

    canvas.drawLine(
      Offset(20, size.height * 0.48),
      Offset(size.width - 20, size.height * 0.52),
      smallRoadPaint,
    );

    _pin(canvas, Offset(size.width * 0.50, size.height * 0.48), primary, 15);
    _pin(canvas, Offset(size.width * 0.70, size.height * 0.32), Colors.red, 10);
    _pin(canvas, Offset(size.width * 0.28, size.height * 0.62), Colors.red, 10);
  }

  void _pin(Canvas canvas, Offset center, Color color, double radius) {
    final paint = Paint()..color = color;
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius * 0.45, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}