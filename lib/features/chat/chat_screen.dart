import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int selectedIndex = 2;

  String searchText = '';
  String quickFilter = 'Todos';
  String bloodFilter = 'Todos';
  String locationFilter = 'Todas';
  String orderFilter = 'Más recientes';
  String notificationFilter = 'Todas';

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> conversations = [
    {
      'id': 1,
      'name': 'Gianela Vargas',
      'message': 'Estoy disponible para donar A+.',
      'time': '9:30 am',
      'order': 6,
      'blood': 'A+',
      'location': 'Huancayo',
      'favorite': true,
      'muted': false,
      'unread': 2,
      'online': true,
      'image': 'assets/images/perfiles/gianela.png',
      'messages': <Map<String, dynamic>>[
        {
          'type': 'text',
          'text': 'Hola Gianela, ¿sigues disponible?',
          'isMe': true,
          'time': '9:08 am',
        },
        {
          'type': 'text',
          'text': 'Sí, puedo donar sangre A+ hoy.',
          'isMe': false,
          'time': '9:09 am',
        },
        {
          'type': 'text',
          'text': 'Perfecto, te envío la ubicación.',
          'isMe': true,
          'time': '9:10 am',
        },
      ],
    },
    {
      'id': 2,
      'name': 'Balvin Marcos',
      'message': 'Puedo acercarme al hospital.',
      'time': '9:10 am',
      'order': 5,
      'blood': 'O+',
      'location': 'El Tambo',
      'favorite': false,
      'muted': false,
      'unread': 1,
      'online': true,
      'image': 'assets/images/perfiles/balvin.png',
      'messages': <Map<String, dynamic>>[
        {
          'type': 'text',
          'text': 'Hola Balvin, necesitamos donante O+.',
          'isMe': true,
          'time': '9:06 am',
        },
        {
          'type': 'text',
          'text': 'Hola, estoy disponible para donar.',
          'isMe': false,
          'time': '9:07 am',
        },
        {
          'type': 'text',
          'text': '¿Puedes acercarte al Hospital Carrión?',
          'isMe': true,
          'time': '9:08 am',
        },
        {
          'type': 'text',
          'text': 'Sí, puedo ir ahora mismo.',
          'isMe': false,
          'time': '9:09 am',
        },
      ],
    },
    {
      'id': 3,
      'name': 'María Rojas',
      'message': 'Muchas gracias por la ayuda.',
      'time': '8:45 am',
      'order': 4,
      'blood': 'B+',
      'location': 'Chilca',
      'favorite': true,
      'muted': false,
      'unread': 0,
      'online': false,
      'image': 'assets/images/perfiles/maria.png',
      'messages': <Map<String, dynamic>>[
        {
          'type': 'text',
          'text': 'Señora María, ya encontramos un donante cercano.',
          'isMe': true,
          'time': '8:40 am',
        },
        {
          'type': 'text',
          'text': 'Muchas gracias por la ayuda.',
          'isMe': false,
          'time': '8:42 am',
        },
      ],
    },
    {
      'id': 4,
      'name': 'Hospital Carrión',
      'message': 'Solicitud urgente registrada.',
      'time': '8:20 am',
      'order': 3,
      'blood': 'AB+',
      'location': 'Huancayo',
      'favorite': false,
      'muted': true,
      'unread': 0,
      'online': true,
      'image': 'assets/images/perfiles/hospital.png',
      'messages': <Map<String, dynamic>>[
        {
          'type': 'text',
          'text': 'Se registró una solicitud urgente AB+.',
          'isMe': false,
          'time': '8:15 am',
        },
        {
          'type': 'text',
          'text': 'Estamos buscando donantes cercanos.',
          'isMe': true,
          'time': '8:17 am',
        },
      ],
    },
    {
      'id': 5,
      'name': 'Lucía Pérez',
      'message': '¿Aún necesitas donantes?',
      'time': 'Ayer',
      'order': 2,
      'blood': 'A-',
      'location': 'Concepción',
      'favorite': false,
      'muted': false,
      'unread': 0,
      'online': false,
      'image': 'assets/images/perfiles/lucia.png',
      'messages': <Map<String, dynamic>>[
        {
          'type': 'text',
          'text': 'Hola, vi tu solicitud de sangre.',
          'isMe': false,
          'time': '7:20 pm',
        },
        {
          'type': 'text',
          'text': 'Sí, todavía necesitamos apoyo.',
          'isMe': true,
          'time': '7:21 pm',
        },
      ],
    },
    {
      'id': 6,
      'name': 'José Antonio',
      'message': 'Te enviaré los documentos.',
      'time': 'Ayer',
      'order': 1,
      'blood': 'O-',
      'location': 'San Ramón',
      'favorite': false,
      'muted': false,
      'unread': 0,
      'online': true,
      'image': 'assets/images/perfiles/jose.png',
      'messages': <Map<String, dynamic>>[
        {
          'type': 'text',
          'text': 'Soy donante O-, ¿qué requisitos debo llevar?',
          'isMe': false,
          'time': '6:00 pm',
        },
        {
          'type': 'text',
          'text': 'Lleva tu DNI y evita alimentos grasosos.',
          'isMe': true,
          'time': '6:02 pm',
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'title': 'Donante encontrado',
      'message': 'Balvin Marcos aceptó donar sangre O+.',
      'time': '9:30 am',
      'read': false,
      'icon': Icons.volunteer_activism,
    },
    {
      'id': 2,
      'title': 'Nuevo mensaje',
      'message': 'Gianela Vargas respondió tu solicitud.',
      'time': '9:10 am',
      'read': false,
      'icon': Icons.chat_bubble,
    },
    {
      'id': 3,
      'title': 'Solicitud atendida',
      'message': 'Hospital Carrión confirmó la recepción de sangre.',
      'time': '8:45 am',
      'read': true,
      'icon': Icons.fact_check,
    },
    {
      'id': 4,
      'title': 'Recordatorio',
      'message': 'No olvides confirmar tu disponibilidad.',
      'time': 'Ayer',
      'read': true,
      'icon': Icons.event_available,
    },
  ];

  List<Map<String, dynamic>> get filteredConversations {
    List<Map<String, dynamic>> result = conversations.where((item) {
      final search = searchText.toLowerCase();
      final name = item['name'].toString().toLowerCase();
      final message = item['message'].toString().toLowerCase();
      final blood = item['blood'].toString().toLowerCase();
      final location = item['location'].toString().toLowerCase();

      final matchSearch = name.contains(search) ||
          message.contains(search) ||
          blood.contains(search) ||
          location.contains(search);

      final matchQuick = quickFilter == 'Todos' ||
          (quickFilter == 'No leídos' && item['unread'] > 0) ||
          (quickFilter == 'Favoritos' && item['favorite'] == true);

      final matchBlood =
          bloodFilter == 'Todos' || item['blood'] == bloodFilter;

      final matchLocation =
          locationFilter == 'Todas' || item['location'] == locationFilter;

      return matchSearch && matchQuick && matchBlood && matchLocation;
    }).toList();

    if (orderFilter == 'Más recientes') {
      result.sort((a, b) => b['order'].compareTo(a['order']));
    } else if (orderFilter == 'Más antiguos') {
      result.sort((a, b) => a['order'].compareTo(b['order']));
    } else if (orderFilter == 'A-Z') {
      result.sort((a, b) => a['name'].compareTo(b['name']));
    } else if (orderFilter == 'Z-A') {
      result.sort((a, b) => b['name'].compareTo(a['name']));
    }

    return result;
  }

  List<Map<String, dynamic>> get filteredNotifications {
    return notifications.where((item) {
      if (notificationFilter == 'No leídas') return item['read'] == false;
      if (notificationFilter == 'Leídas') return item['read'] == true;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 1) return _profilePage();
    if (selectedIndex == 3) return _notificationsPage();
    return _conversationsPage();
  }

  Widget _conversationsPage() {
    final primary = Theme.of(context).primaryColor;
    final unreadNotifications =
        notifications.where((item) => item['read'] == false).length;

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Comunicación',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                selectedIndex = 3;
              });
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.notifications_none, color: primary),
                if (unreadNotifications > 0)
                  Positioned(
                    right: -5,
                    top: -6,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: primary,
                      child: Text(
                        unreadNotifications.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
            child: Row(
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
                      hintText: 'Buscar conversación...',
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: _showFilterSheet,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.tune, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                _quickChip('Todos'),
                const SizedBox(width: 8),
                _quickChip('No leídos'),
                const SizedBox(width: 8),
                _quickChip('Favoritos'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filteredConversations.isEmpty
                ? const Center(
                    child: Text(
                      'No se encontraron conversaciones',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: filteredConversations.length,
                    itemBuilder: (context, index) {
                      final item = filteredConversations[index];

                      return Dismissible(
                        key: ValueKey(item['id']),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) async {
                          await _confirmDeleteConversation(item);
                          return false;
                        },
                        background: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.only(right: 22),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 14,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ListTile(
                            minVerticalPadding: 8,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            onTap: () {
                              setState(() {
                                item['unread'] = 0;
                              });
                              _openChat(item);
                            },
                            leading: _ProfileAvatar(
                              image: item['image'],
                              radius: 28,
                              online: item['online'],
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                if (item['favorite'])
                                  Icon(Icons.star, size: 16, color: primary),
                                if (item['muted'])
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Icon(
                                      Icons.notifications_off,
                                      size: 15,
                                      color: Colors.black38,
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Text(
                              item['message'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 118,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          item['time'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        item['unread'] > 0
                                            ? CircleAvatar(
                                                radius: 10,
                                                backgroundColor: primary,
                                                child: Text(
                                                  item['unread'].toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            : _bloodBadge(item['blood']),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                    height: 38,
                                    child: PopupMenuButton<String>(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.more_vert,
                                        size: 22,
                                      ),
                                      onSelected: (value) {
                                        if (value == 'profile') {
                                          _showConversationProfile(item);
                                        } else if (value == 'favorite') {
                                          setState(() {
                                            item['favorite'] =
                                                !item['favorite'];
                                          });
                                        } else if (value == 'mute') {
                                          setState(() {
                                            item['muted'] = !item['muted'];
                                          });
                                        } else if (value == 'delete') {
                                          _confirmDeleteConversation(item);
                                        }
                                      },
                                      itemBuilder: (_) => [
                                        const PopupMenuItem(
                                          value: 'profile',
                                          child: Text('Ver perfil'),
                                        ),
                                        PopupMenuItem(
                                          value: 'favorite',
                                          child: Text(
                                            item['favorite']
                                                ? 'Quitar favorito'
                                                : 'Agregar a favoritos',
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'mute',
                                          child: Text(
                                            item['muted']
                                                ? 'Activar notificaciones'
                                                : 'Silenciar',
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Text('Eliminar conversación'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _quickChip(String label) {
    final primary = Theme.of(context).primaryColor;
    final selected = quickFilter == label;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            quickFilter = label;
          });
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? primary : Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bloodBadge(String text) {
    final primary = Theme.of(context).primaryColor;

    return Container(
      constraints: const BoxConstraints(
        minWidth: 30,
        minHeight: 22,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  void _openChat(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _ChatDetailPage(
          user: item,
          onChanged: () {
            setState(() {});
          },
          onDelete: () {
            setState(() {
              conversations.remove(item);
            });
          },
        ),
      ),
    );
  }

  Future<void> _confirmDeleteConversation(Map<String, dynamic> item) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar conversación'),
        content: Text('¿Deseas eliminar la conversación con ${item['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        conversations.remove(item);
      });
    }
  }

  void _showFilterSheet() {
    final primary = Theme.of(context).primaryColor;

    String tempBlood = bloodFilter;
    String tempLocation = locationFilter;
    String tempOrder = orderFilter;

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

    final locations = [
      'Todas',
      'Huancayo',
      'El Tambo',
      'Chilca',
      'Concepción',
      'San Ramón',
    ];

    final orders = ['Más recientes', 'Más antiguos', 'A-Z', 'Z-A'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.pink.shade50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 8),
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
                                  'Filtros de comunicación',
                                  style: TextStyle(
                                    fontSize: 20,
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
                            const SizedBox(height: 20),
                            const Text(
                              'Ubicación',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            ...locations.map((location) {
                              final selected = tempLocation == location;
                              return _filterOption(
                                icon: Icons.location_on_outlined,
                                text: location,
                                selected: selected,
                                primary: primary,
                                onTap: () {
                                  modalSetState(() {
                                    tempLocation = location;
                                  });
                                },
                              );
                            }),
                            const SizedBox(height: 16),
                            const Text(
                              'Ordenar por',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            ...orders.map((order) {
                              final selected = tempOrder == order;
                              return _filterOption(
                                icon: Icons.sort,
                                text: order,
                                selected: selected,
                                primary: primary,
                                onTap: () {
                                  modalSetState(() {
                                    tempOrder = order;
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
                      color: Colors.pink.shade50,
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                modalSetState(() {
                                  tempBlood = 'Todos';
                                  tempLocation = 'Todas';
                                  tempOrder = 'Más recientes';
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
                                  bloodFilter = tempBlood;
                                  locationFilter = tempLocation;
                                  orderFilter = tempOrder;
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
    required IconData icon,
    required String text,
    required bool selected,
    required Color primary,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: selected ? primary.withOpacity(0.08) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? primary : Colors.black12,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected ? primary : Colors.black54,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(text)),
              if (selected) Icon(Icons.check_circle, color: primary, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationsPage() {
    final primary = Theme.of(context).primaryColor;
    final unread = notifications.where((e) => e['read'] == false).length;

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            setState(() {
              selectedIndex = 2;
            });
          },
        ),
        centerTitle: true,
        title: const Text(
          'Notificaciones',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                for (final item in notifications) {
                  item['read'] = true;
                }
              });
            },
            icon: Icon(Icons.done_all, color: primary),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                _notificationChip('Todas', notifications.length),
                const SizedBox(width: 8),
                _notificationChip('No leídas', unread),
                const SizedBox(width: 8),
                _notificationChip('Leídas', null),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: filteredNotifications.isEmpty
                ? const Center(
                    child: Text(
                      'No hay notificaciones',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final item = filteredNotifications[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: item['read']
                              ? Colors.white
                              : primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 27,
                              backgroundColor: primary,
                              child: Icon(item['icon'], color: Colors.white),
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
                                          item['title'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        item['time'],
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['message'],
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'read') {
                                  setState(() {
                                    item['read'] = true;
                                  });
                                } else if (value == 'unread') {
                                  setState(() {
                                    item['read'] = false;
                                  });
                                } else if (value == 'delete') {
                                  final removed =
                                      Map<String, dynamic>.from(item);

                                  setState(() {
                                    notifications.remove(item);
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          const Text('Notificación eliminada'),
                                      action: SnackBarAction(
                                        label: 'Deshacer',
                                        onPressed: () {
                                          setState(() {
                                            notifications.add(removed);
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                } else if (value == 'detail') {
                                  _showNotificationDetail(item);
                                }
                              },
                              itemBuilder: (_) => [
                                PopupMenuItem(
                                  value: item['read'] ? 'unread' : 'read',
                                  child: Text(
                                    item['read']
                                        ? 'Marcar como no leída'
                                        : 'Marcar como leída',
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'detail',
                                  child: Text('Ver detalles'),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Eliminar notificación'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _notificationChip(String label, int? count) {
    final primary = Theme.of(context).primaryColor;
    final selected = notificationFilter == label;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            notificationFilter = label;
          });
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? primary : Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            count == null ? label : '$label $count',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  void _showNotificationDetail(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(item['title']),
        content: Text(item['message']),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _profilePage() {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mi perfil',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                children: [
                  _ProfileAvatar(
                    image: 'assets/images/perfiles/jose.png',
                    radius: 48,
                    online: true,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Ángel Macha',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Text(
                    'angel.macha@gmail.com',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _profileInfo('Grupo', 'O+'),
                      _profileInfo('Zona', 'El Tambo'),
                      _profileInfo('Estado', 'Activo'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _profileOption(Icons.edit, 'Editar perfil'),
            _profileOption(Icons.favorite, 'Mis donaciones'),
            _profileOption(Icons.history, 'Historial'),
            _profileOption(Icons.settings, 'Preferencias'),
            _profileOption(Icons.help_outline, 'Ayuda y soporte'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
                style: ElevatedButton.styleFrom(backgroundColor: primary),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _profileInfo(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _profileOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _bottomBar() {
    final primary = Theme.of(context).primaryColor;

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
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home-page');
            return;
          }

          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Comunicación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
        ],
      ),
    );
  }

  void _showConversationProfile(Map<String, dynamic> user) {
    final primary = Theme.of(context).primaryColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.pink.shade50,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
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
                  image: user['image'],
                  radius: 55,
                  online: user['online'],
                ),
                const SizedBox(height: 12),
                Text(
                  user['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  user['online'] ? 'En línea' : 'Desconectado',
                  style: TextStyle(
                    color: user['online'] ? Colors.green : Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      _infoRow(Icons.bloodtype, 'Tipo de sangre', user['blood']),
                      _infoRow(Icons.location_on, 'Ubicación', user['location']),
                      _infoRow(
                        user['favorite'] ? Icons.star : Icons.star_border,
                        'Favorito',
                        user['favorite'] ? 'Sí' : 'No',
                      ),
                      _infoRow(
                        user['muted']
                            ? Icons.notifications_off
                            : Icons.notifications_active,
                        'Notificaciones',
                        user['muted'] ? 'Silenciadas' : 'Activas',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
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
                          _openChat(user);
                        },
                        icon: const Icon(Icons.message),
                        label: const Text('Mensaje'),
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

  Widget _infoRow(IconData icon, String title, String value) {
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
}

class _ChatDetailPage extends StatefulWidget {
  final Map<String, dynamic> user;
  final VoidCallback onChanged;
  final VoidCallback onDelete;

  const _ChatDetailPage({
    required this.user,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  State<_ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<_ChatDetailPage> {
  final TextEditingController controller = TextEditingController();
  bool showEmojiPanel = false;

  final List<String> emojis = [
    '😀',
    '😊',
    '😍',
    '😂',
    '😢',
    '🙏',
    '👍',
    '❤️',
    '🔥',
    '👏',
    '😎',
    '🥺',
    '😇',
    '🤝',
    '🩸',
    '🏥',
    '🚑',
    '📍',
  ];

  List<Map<String, dynamic>> get messages {
    return (widget.user['messages'] as List).cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        titleSpacing: 0,
        title: Row(
          children: [
            _ProfileAvatar(
              image: widget.user['image'],
              radius: 24,
              online: widget.user['online'],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.user['name'],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showLocationInfo,
            icon: Icon(Icons.location_on, color: primary),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
                _showUserProfile();
              } else if (value == 'search') {
                _searchInsideChat();
              } else if (value == 'mute') {
                setState(() {
                  widget.user['muted'] = !(widget.user['muted'] as bool);
                });
                widget.onChanged();
              } else if (value == 'delete') {
                _confirmDeleteChat();
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('Ver perfil'),
              ),
              const PopupMenuItem(
                value: 'search',
                child: Text('Buscar en conversación'),
              ),
              PopupMenuItem(
                value: 'mute',
                child: Text(
                  widget.user['muted']
                      ? 'Activar notificaciones'
                      : 'Silenciar notificaciones',
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Eliminar conversación'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Hoy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: messages.length,
              itemBuilder: (_, index) {
                final msg = messages[index];

                if (msg['type'] == 'location') {
                  return _LocationBubble(
                    isMe: msg['isMe'],
                    title: msg['title'],
                    address: msg['address'],
                    time: msg['time'],
                    onTap: _showLocationInfo,
                  );
                }

                return _MessageBubble(
                  text: msg['text'],
                  isMe: msg['isMe'],
                  time: msg['time'],
                  image: widget.user['image'],
                );
              },
            ),
          ),
          _messageInput(primary),
          if (showEmojiPanel) _emojiPanel(),
        ],
      ),
    );
  }

  Widget _messageInput(Color primary) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primary,
            child: IconButton(
              onPressed: _sendLocationCard,
              icon: const Icon(Icons.add_location_alt, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Escribir mensaje...',
                filled: true,
                fillColor: Colors.grey.shade100,
                prefixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showEmojiPanel = !showEmojiPanel;
                    });
                  },
                  icon: Icon(Icons.emoji_emotions_outlined, color: primary),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 26,
            backgroundColor: primary,
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emojiPanel() {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: GridView.builder(
        itemCount: emojis.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
        ),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              final text = '${controller.text}${emojis[index]}';
              controller.text = text;
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            },
            child: Center(
              child: Text(
                emojis[index],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        },
      ),
    );
  }

  void _sendMessage() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add({
        'type': 'text',
        'text': text,
        'isMe': true,
        'time': 'Ahora',
      });

      widget.user['message'] = text;
      widget.user['time'] = 'Ahora';
      controller.clear();
      showEmojiPanel = false;
    });

    widget.onChanged();
  }

  void _sendLocationCard() {
    setState(() {
      messages.add({
        'type': 'location',
        'title': 'Hospital Carrión',
        'address': 'Av. Daniel Alcides Carrión, Huancayo',
        'isMe': true,
        'time': 'Ahora',
      });

      widget.user['message'] = 'Ubicación enviada';
      widget.user['time'] = 'Ahora';
    });

    widget.onChanged();
  }

  void _showLocationInfo() {
    final primary = Theme.of(context).primaryColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.pink.shade50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, size: 64, color: primary),
                const SizedBox(height: 12),
                const Text(
                  'Hospital Carrión',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.user['location']}, Huancayo',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _sendLocationCard();
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Enviar ubicación al chat'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showUserProfile() {
    final primary = Theme.of(context).primaryColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.pink.shade50,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
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
                  image: widget.user['image'],
                  radius: 55,
                  online: widget.user['online'],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.user['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  widget.user['online'] ? 'En línea' : 'Desconectado',
                  style: TextStyle(
                    color:
                        widget.user['online'] ? Colors.green : Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      _profileRow(
                        Icons.bloodtype,
                        'Tipo de sangre',
                        widget.user['blood'],
                      ),
                      _profileRow(
                        Icons.location_on,
                        'Ubicación',
                        widget.user['location'],
                      ),
                      _profileRow(
                        widget.user['favorite']
                            ? Icons.star
                            : Icons.star_border,
                        'Favorito',
                        widget.user['favorite'] ? 'Sí' : 'No',
                      ),
                      _profileRow(
                        widget.user['muted']
                            ? Icons.notifications_off
                            : Icons.notifications_active,
                        'Notificaciones',
                        widget.user['muted'] ? 'Silenciadas' : 'Activas',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
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
                          _showLocationInfo();
                        },
                        icon: const Icon(Icons.location_on),
                        label: const Text('Ubicación'),
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

  Widget _profileRow(IconData icon, String title, String value) {
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

  void _searchInsideChat() {
    final searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Buscar mensaje'),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Escribe una palabra',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final query = searchController.text.toLowerCase();

              final count = messages.where((msg) {
                return msg['type'] == 'text' &&
                    msg['text'].toString().toLowerCase().contains(query);
              }).length;

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Se encontraron $count mensajes')),
              );
            },
            child: const Text('Buscar'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteChat() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar conversación'),
        content: Text(
          '¿Deseas eliminar la conversación con ${widget.user['name']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDelete();
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  final String image;

  const _MessageBubble({
    required this.text,
    required this.isMe,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            _ProfileAvatar(image: image, radius: 18, online: false),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isMe ? primary : Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.black45, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationBubble extends StatelessWidget {
  final bool isMe;
  final String title;
  final String address;
  final String time;
  final VoidCallback onTap;

  const _LocationBubble({
    required this.isMe,
    required this.title,
    required this.address,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 290,
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                height: 82,
                width: 82,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(Icons.location_on, color: primary, size: 42),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ver ubicación',
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        time,
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                child: Icon(
                  Icons.person,
                  color: primary,
                  size: radius,
                ),
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