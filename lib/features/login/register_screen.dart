import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool acceptTerms = true;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(Icons.arrow_back),
              ),

              const SizedBox(height: 16),

              const Text(
                'Regístrate',

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              const Text(
                'Ingresa tu información personal a continuación para registrarte y crear tu cuenta de usuario.',

                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 30),

              _inputField('Nombre completo'),

              const SizedBox(height: 16),

              _inputField('Correo electrónico'),

              const SizedBox(height: 16),

              _inputField('Contraseña', obscureText: true),

              const SizedBox(height: 16),

              _inputField('+51'),

              const SizedBox(height: 16),

              _inputField('Perú'),

              const SizedBox(height: 10),

              Row(
                children: [
                  Checkbox(
                    value: acceptTerms,

                    activeColor: primaryColor,

                    side: BorderSide(color: primaryColor),

                    onChanged: (value) {
                      setState(() {
                        acceptTerms = value ?? false;
                      });
                    },
                  ),

                  const Expanded(
                    child: Text(
                      'Aceptar los términos y condiciones',

                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  onPressed: () {
                    debugPrint('Registrarse');
                  },

                  child: const Text(
                    'REGISTRARSE',

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Row(
                children: [
                  Expanded(child: Divider()),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),

                    child: Text(
                      'o',

                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  _socialButton('G', () {
                    debugPrint('Registro con Google');
                  }),

                  const SizedBox(width: 32),

                  _socialButton('f', () {
                    debugPrint('Registro con Facebook');
                  }),
                ],
              ),

              const SizedBox(height: 28),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      'Ya tienes una cuenta ? ',

                      style: TextStyle(fontSize: 13),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: Text(
                        'Iniciar sesión',

                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
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

  Widget _inputField(String hintText, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,

      decoration: InputDecoration(
        hintText: hintText,

        filled: true,
        fillColor: const Color(0xFFF3F3F3),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _socialButton(String text, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(8),

        onTap: onTap,

        child: Container(
          width: 48,
          height: 40,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),

            borderRadius: BorderRadius.circular(8),
          ),

          child: Text(
            text,

            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
