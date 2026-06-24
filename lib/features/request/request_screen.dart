import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController pacienteController = TextEditingController();
  final TextEditingController contactoController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  String? tipoSangre;
  String genero = 'Masculino';
  double cantidad = 2;

  final Color primaryColor = const Color(0xFFE9004F);

  final List<String> tipos = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Expanded(
                      child: Text(
                        'Crear una solicitud',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 25),

                const Text(
                  'NOMBRE DEL PACIENTE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                _input(
                  controller: pacienteController,
                  hint: 'Nombre completo',
                  icon: Icons.person_outline,
                  validator: 'Ingrese el nombre del paciente',
                ),

                const SizedBox(height: 20),

                const Text(
                  'Tipo de Sangre',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 18,
                  runSpacing: 14,
                  children: tipos.map((tipo) {
                    final seleccionado = tipoSangre == tipo;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          tipoSangre = tipo;
                        });
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: seleccionado
                            ? primaryColor
                            : Colors.grey.shade200,
                        child: Text(
                          tipo,
                          style: TextStyle(
                            color: seleccionado ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Cantidad de Sangre',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Slider(
                  value: cantidad,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  activeColor: primaryColor,
                  label: '${cantidad.toInt()} unidades',
                  onChanged: (value) {
                    setState(() {
                      cantidad = value;
                    });
                  },
                ),

                Center(child: Text('${cantidad.toInt()} unidades')),

                const SizedBox(height: 15),

                const Text(
                  'Número de contacto',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                _input(
                  controller: contactoController,
                  hint: 'Número móvil',
                  icon: Icons.phone_android,
                  keyboardType: TextInputType.phone,
                  validator: 'Ingrese un número de contacto',
                ),

                const SizedBox(height: 18),

                const Text(
                  'Ubicación de Entrega',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                _input(
                  controller: ubicacionController,
                  hint: 'Seleccionar ubicación',
                  icon: Icons.location_on_outlined,
                  validator: 'Ingrese la ubicación',
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: _box(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: genero,
                            items: const [
                              DropdownMenuItem(
                                value: 'Masculino',
                                child: Text('Masculino'),
                              ),
                              DropdownMenuItem(
                                value: 'Femenino',
                                child: Text('Femenino'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                genero = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: fechaController,
                        decoration: _decoration('DD/MM/AAAA', Icons.date_range),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      if (tipoSangre == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Seleccione un tipo de sangre'),
                          ),
                        );
                        return;
                      }

                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Solicitud enviada correctamente'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Enviar solicitud',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _decoration(hint, icon),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validator;
        }
        return null;
      },
    );
  }

  InputDecoration _decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _box({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
