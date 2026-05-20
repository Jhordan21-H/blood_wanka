import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../login/login_screen.dart';

enum AuthSection { register, forgotPassword, verificationCode, resetPassword }

class AuthScreen extends StatefulWidget {
  final AuthSection initialSection;

  const AuthScreen({super.key, this.initialSection = AuthSection.register});

  const AuthScreen.forgotPassword({super.key})
    : initialSection = AuthSection.forgotPassword;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthSection currentSection;

  final _registerFormKey = GlobalKey<FormState>();
  final _forgotFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController recoveryEmailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatNewPasswordController =
      TextEditingController();

  bool acceptTerms = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool hideNewPassword = true;
  bool hideRepeatNewPassword = true;

  String selectedDistrict = 'Huancayo';

  final List<String> huancayoDistricts = [
    'Huancayo',
    'El Tambo',
    'Chilca',
    'Huancán',
    'Pilcomayo',
    'San Agustín de Cajas',
    'San Jerónimo de Tunán',
    'Sapallanga',
    'Sicaya',
    'Hualhuas',
    'Huayucachi',
    'Ingenio',
    'Quichuay',
    'Quilcas',
    'Saño',
    'Viques',
    'Pucará',
    'Chupuro',
    'Chongos Alto',
    'Colca',
    'Cullhuas',
    'Pariahuanca',
  ];

  @override
  void initState() {
    super.initState();
    currentSection = widget.initialSection;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    dniController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    recoveryEmailController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    repeatNewPasswordController.dispose();
    super.dispose();
  }

  void changeSection(AuthSection section) {
    setState(() {
      currentSection = section;
    });
  }

  void goToLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  void goBack() {
    if (currentSection == AuthSection.register ||
        currentSection == AuthSection.forgotPassword) {
      goToLoginScreen();
      return;
    }

    if (currentSection == AuthSection.verificationCode) {
      changeSection(AuthSection.forgotPassword);
      return;
    }

    if (currentSection == AuthSection.resetPassword) {
      changeSection(AuthSection.verificationCode);
      return;
    }
  }

  void showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email.trim());
  }

  bool hasUppercase(String value) => RegExp(r'[A-Z]').hasMatch(value);
  bool hasLowercase(String value) => RegExp(r'[a-z]').hasMatch(value);
  bool hasNumber(String value) => RegExp(r'[0-9]').hasMatch(value);
  bool hasSymbol(String value) =>
      RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/]').hasMatch(value);

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Ingrese su correo.';
    }

    if (!email.contains('@')) {
      return 'Debe contener @.';
    }

    if (!email.contains('.')) {
      return 'Debe contener un punto.';
    }

    if (!isValidEmail(email)) {
      return 'Correo no válido.';
    }

    return null;
  }

  String? validateStrongPassword(String? value) {
    final password = value?.trim() ?? '';

    if (password.isEmpty) {
      return 'Ingrese una contraseña.';
    }

    if (password.length < 8) {
      return 'Mínimo 8 caracteres.';
    }

    if (!hasUppercase(password)) {
      return 'Incluya una mayúscula.';
    }

    if (!hasLowercase(password)) {
      return 'Incluya una minúscula.';
    }

    if (!hasNumber(password)) {
      return 'Incluya un número.';
    }

    if (!hasSymbol(password)) {
      return 'Incluya un símbolo.';
    }

    return null;
  }

  void registerUser() {
    if (!_registerFormKey.currentState!.validate()) {
      return;
    }

    if (!acceptTerms) {
      showMessage('Debe aceptar los términos y condiciones.', isError: true);
      return;
    }

    showMessage('Registro correcto. Redirigiendo al login...');

    Future.delayed(const Duration(milliseconds: 650), () {
      if (mounted) {
        goToLoginScreen();
      }
    });
  }

  void sendRecoveryCode() {
    if (!_forgotFormKey.currentState!.validate()) {
      return;
    }

    showMessage('Código enviado al correo registrado.');
    changeSection(AuthSection.verificationCode);
  }

  void verifyCode() {
    if (!_codeFormKey.currentState!.validate()) {
      return;
    }

    if (codeController.text.trim() == '12345') {
      showMessage('Código verificado correctamente.');
      changeSection(AuthSection.resetPassword);
    } else {
      showMessage(
        'Código incorrecto. Para la prueba use 12345.',
        isError: true,
      );
    }
  }

  void resetPassword() {
    if (!_resetFormKey.currentState!.validate()) {
      return;
    }

    showMessage('Contraseña actualizada. Redirigiendo al login...');

    Future.delayed(const Duration(milliseconds: 650), () {
      if (mounted) {
        goToLoginScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Stack(
        children: [
          buildBackground(primaryColor),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = MediaQuery.of(context).size.width >= 820;

                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 760),
                      child: isWide
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 345,
                                  child: buildFormCard(primaryColor),
                                ),
                                const SizedBox(width: 18),
                                SizedBox(
                                  width: 300,
                                  child: buildInfoCard(primaryColor),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 345,
                                  ),
                                  child: buildFormCard(primaryColor),
                                ),
                                const SizedBox(height: 14),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 345,
                                  ),
                                  child: buildInfoCard(primaryColor),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackground(Color primaryColor) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF1F5), Color(0xFFF8F9FD), Color(0xFFFFFAFB)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -70,
            child: buildBlurCircle(
              size: 210,
              color: primaryColor.withOpacity(0.14),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -80,
            child: buildBlurCircle(
              size: 240,
              color: primaryColor.withOpacity(0.12),
            ),
          ),
          Positioned(
            top: 160,
            right: 36,
            child: Icon(
              Icons.bloodtype,
              size: 46,
              color: primaryColor.withOpacity(0.08),
            ),
          ),
          Positioned(
            bottom: 160,
            left: 30,
            child: Icon(
              Icons.favorite,
              size: 42,
              color: primaryColor.withOpacity(0.08),
            ),
          ),
          Positioned(
            top: 70,
            left: 40,
            child: Icon(
              Icons.volunteer_activism,
              size: 34,
              color: primaryColor.withOpacity(0.07),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBlurCircle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget buildFormCard(Color primaryColor) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Container(
        key: ValueKey(currentSection),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.96),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTopBar(primaryColor),
            const SizedBox(height: 14),
            buildCurrentSection(),
          ],
        ),
      ),
    );
  }

  Widget buildTopBar(Color primaryColor) {
    return Row(
      children: [
        InkWell(
          onTap: goBack,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F5F8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.arrow_back, size: 19),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            getHeaderPhrase(),
            style: TextStyle(
              color: primaryColor,
              fontSize: 10.6,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  String getHeaderPhrase() {
    if (currentSection == AuthSection.register) {
      return 'DonaSangre';
    }

    if (currentSection == AuthSection.resetPassword) {
      return 'Cuenta segura';
    }

    return 'Recuperación segura';
  }

  Widget buildCurrentSection() {
    switch (currentSection) {
      case AuthSection.register:
        return buildRegisterForm();

      case AuthSection.forgotPassword:
        return buildForgotPasswordForm();

      case AuthSection.verificationCode:
        return buildVerificationCodeForm();

      case AuthSection.resetPassword:
        return buildResetPasswordForm();
    }
  }

  Widget buildRegisterForm() {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildFormHeader(
            icon: Icons.volunteer_activism_outlined,
            title: 'Crear cuenta',
            subtitle: 'Regístrate para ayudar en la búsqueda de donantes.',
          ),
          const SizedBox(height: 13),
          buildLabeledInput(
            label: 'Nombre completo',
            child: buildInput(
              controller: fullNameController,
              hint: 'Juan Pérez Ramos',
              icon: Icons.person_outline,
              validator: (value) {
                final name = value?.trim() ?? '';

                if (name.isEmpty) {
                  return 'Ingrese su nombre.';
                }

                if (name.length < 6) {
                  return 'Ingrese nombres y apellidos.';
                }

                return null;
              },
            ),
          ),
          const SizedBox(height: 9),
          buildLabeledInput(
            label: 'DNI',
            child: buildInput(
              controller: dniController,
              hint: '76543210',
              icon: Icons.badge_outlined,
              keyboardType: TextInputType.number,
              maxLength: 8,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                final dni = value?.trim() ?? '';

                if (dni.isEmpty) {
                  return 'Ingrese su DNI.';
                }

                if (dni.length != 8) {
                  return 'Debe tener 8 dígitos.';
                }

                return null;
              },
            ),
          ),
          const SizedBox(height: 9),
          buildLabeledInput(
            label: 'Correo electrónico',
            child: buildInput(
              controller: emailController,
              hint: 'usuario@gmail.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            ),
          ),
          const SizedBox(height: 9),
          buildDistrictSelector(),
          const SizedBox(height: 9),
          buildPhoneInput(),
          const SizedBox(height: 9),
          buildLabeledInput(
            label: 'Contraseña',
            child: buildInput(
              controller: passwordController,
              hint: 'Dona@2026',
              icon: Icons.lock_outline,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(
                  hidePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                ),
              ),
              validator: validateStrongPassword,
            ),
          ),
          const SizedBox(height: 8),
          buildLabeledInput(
            label: 'Confirmar contraseña',
            child: buildInput(
              controller: confirmPasswordController,
              hint: 'Repita la contraseña',
              icon: Icons.lock_reset_outlined,
              obscureText: hideConfirmPassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hideConfirmPassword = !hideConfirmPassword;
                  });
                },
                icon: Icon(
                  hideConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                ),
              ),
              validator: (value) {
                final confirm = value?.trim() ?? '';

                if (confirm.isEmpty) {
                  return 'Confirme su contraseña.';
                }

                if (confirm != passwordController.text.trim()) {
                  return 'Las contraseñas no coinciden.';
                }

                return null;
              },
            ),
          ),
          const SizedBox(height: 7),
          buildPasswordTextHint(),
          const SizedBox(height: 7),
          buildTermsCheck(),
          const SizedBox(height: 9),
          buildPrimaryButton(text: 'REGISTRARME', onPressed: registerUser),
          const SizedBox(height: 2),
          TextButton(
            onPressed: goToLoginScreen,
            child: Text(
              'Volver al inicio de sesión',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 11.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForgotPasswordForm() {
    return Form(
      key: _forgotFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildFormHeader(
            icon: Icons.security_outlined,
            title: 'Olvidé mi contraseña',
            subtitle: 'Recibe un código para recuperar tu acceso.',
          ),
          const SizedBox(height: 13),
          buildLabeledInput(
            label: 'Correo electrónico',
            child: buildInput(
              controller: recoveryEmailController,
              hint: 'usuario@gmail.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            ),
          ),
          const SizedBox(height: 12),
          buildSmallAdvice(
            icon: Icons.verified_user_outlined,
            text: 'Enviaremos un código de verificación a tu correo.',
          ),
          const SizedBox(height: 13),
          buildPrimaryButton(
            text: 'ENVIAR CÓDIGO',
            onPressed: sendRecoveryCode,
          ),
          const SizedBox(height: 2),
          TextButton(
            onPressed: goToLoginScreen,
            child: Text(
              'Volver al inicio de sesión',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 11.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVerificationCodeForm() {
    return Form(
      key: _codeFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildFormHeader(
            icon: Icons.pin_outlined,
            title: 'Código de verificación',
            subtitle: 'Para esta prueba usa el código 12345.',
          ),
          const SizedBox(height: 13),
          buildLabeledInput(
            label: 'Código',
            child: buildInput(
              controller: codeController,
              hint: '12345',
              icon: Icons.password_outlined,
              keyboardType: TextInputType.number,
              maxLength: 5,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                final code = value?.trim() ?? '';

                if (code.isEmpty) {
                  return 'Ingrese el código.';
                }

                if (code.length != 5) {
                  return 'Debe tener 5 dígitos.';
                }

                return null;
              },
            ),
          ),
          const SizedBox(height: 13),
          buildPrimaryButton(text: 'VERIFICAR', onPressed: verifyCode),
          const SizedBox(height: 2),
          TextButton(
            onPressed: () {
              showMessage('Código reenviado. Use 12345.');
            },
            child: Text(
              'Reenviar código',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 11.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResetPasswordForm() {
    return Form(
      key: _resetFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildFormHeader(
            icon: Icons.lock_reset_outlined,
            title: 'Nueva contraseña',
            subtitle: 'Crea una clave segura para tu cuenta.',
          ),
          const SizedBox(height: 13),
          buildLabeledInput(
            label: 'Nueva contraseña',
            child: buildInput(
              controller: newPasswordController,
              hint: 'Donar@2026',
              icon: Icons.lock_outline,
              obscureText: hideNewPassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hideNewPassword = !hideNewPassword;
                  });
                },
                icon: Icon(
                  hideNewPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                ),
              ),
              validator: validateStrongPassword,
            ),
          ),
          const SizedBox(height: 8),
          buildLabeledInput(
            label: 'Confirmar nueva contraseña',
            child: buildInput(
              controller: repeatNewPasswordController,
              hint: 'Repita la contraseña',
              icon: Icons.lock_reset_outlined,
              obscureText: hideRepeatNewPassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hideRepeatNewPassword = !hideRepeatNewPassword;
                  });
                },
                icon: Icon(
                  hideRepeatNewPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                ),
              ),
              validator: (value) {
                final repeat = value?.trim() ?? '';

                if (repeat.isEmpty) {
                  return 'Confirme la contraseña.';
                }

                if (repeat != newPasswordController.text.trim()) {
                  return 'Las contraseñas no coinciden.';
                }

                return null;
              },
            ),
          ),
          const SizedBox(height: 7),
          buildPasswordTextHint(),
          const SizedBox(height: 13),
          buildPrimaryButton(
            text: 'GUARDAR CONTRASEÑA',
            onPressed: resetPassword,
          ),
        ],
      ),
    );
  }

  Widget buildInfoCard(Color primaryColor) {
    final info = getSideInfo();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.72),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primaryColor.withOpacity(0.14)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.09),
            blurRadius: 18,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        children: [
          buildDonationIllustration(primaryColor, info.mainIcon),
          const SizedBox(height: 14),
          Text(
            info.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF202020),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            info.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.2,
              height: 1.4,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          buildInfoItem(icon: info.iconOne, text: info.textOne),
          const SizedBox(height: 8),
          buildInfoItem(icon: info.iconTwo, text: info.textTwo),
          const SizedBox(height: 8),
          buildInfoItem(icon: info.iconThree, text: info.textThree),
        ],
      ),
    );
  }

  SideInfo getSideInfo() {
    if (currentSection == AuthSection.register) {
      return const SideInfo(
        title: 'Donar sangre salva vidas',
        description:
            'Un registro correcto ayuda a contactar donantes cercanos con mayor rapidez.',
        mainIcon: Icons.volunteer_activism_outlined,
        iconOne: Icons.bloodtype_outlined,
        textOne: 'Apoya emergencias médicas.',
        iconTwo: Icons.location_on_outlined,
        textTwo: 'Ubica usuarios por distrito.',
        iconThree: Icons.phone_android_outlined,
        textThree: 'Facilita el contacto directo.',
      );
    }

    if (currentSection == AuthSection.forgotPassword ||
        currentSection == AuthSection.verificationCode) {
      return const SideInfo(
        title: 'Recupera tu acceso',
        description: 'La verificación por correo ayuda a proteger tu cuenta.',
        mainIcon: Icons.security_outlined,
        iconOne: Icons.email_outlined,
        textOne: 'Confirma tu identidad.',
        iconTwo: Icons.pin_outlined,
        textTwo: 'Evita accesos no autorizados.',
        iconThree: Icons.verified_user_outlined,
        textThree: 'Protege tus datos personales.',
      );
    }

    return const SideInfo(
      title: 'Contraseña segura',
      description: 'Una clave fuerte reduce riesgos y protege tu información.',
      mainIcon: Icons.lock_reset_outlined,
      iconOne: Icons.lock_outline,
      textOne: 'Mínimo 8 caracteres.',
      iconTwo: Icons.password_outlined,
      textTwo: 'Incluye número y símbolo.',
      iconThree: Icons.shield_outlined,
      textThree: 'No compartas tus credenciales.',
    );
  }

  Widget buildDonationIllustration(Color primaryColor, IconData icon) {
    return Container(
      width: 118,
      height: 118,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.14),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.09),
              shape: BoxShape.circle,
            ),
          ),
          Icon(icon, color: primaryColor, size: 48),
          Positioned(
            right: 20,
            bottom: 21,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(Icons.bloodtype, color: Colors.white, size: 15),
            ),
          ),
          Positioned(
            left: 23,
            top: 23,
            child: Icon(
              Icons.favorite,
              color: primaryColor.withOpacity(0.55),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final primaryColor = Theme.of(context).primaryColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.09),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: primaryColor, size: 23),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF202020),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.8,
                  height: 1.35,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDistrictSelector() {
    return buildLabeledInput(
      label: 'Distrito',
      child: DropdownButtonFormField<String>(
        value: selectedDistrict,
        isExpanded: true,
        decoration: buildFieldDecoration(
          hint: 'Seleccione distrito',
          icon: Icons.location_city_outlined,
        ),
        items: huancayoDistricts.map((district) {
          return DropdownMenuItem<String>(
            value: district,
            child: Text(district, overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: (value) {
          if (value == null) return;

          setState(() {
            selectedDistrict = value;
          });
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Seleccione su distrito.';
          }

          return null;
        },
      ),
    );
  }

  Widget buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Celular',
          style: TextStyle(
            fontSize: 11.8,
            fontWeight: FontWeight.w800,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCountryCodeBox(),
            const SizedBox(width: 8),
            Expanded(
              child: buildInput(
                controller: phoneController,
                hint: '987654321',
                icon: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone,
                maxLength: 9,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final phone = value?.trim() ?? '';

                  if (phone.isEmpty) {
                    return 'Ingrese su celular.';
                  }

                  if (!phone.startsWith('9')) {
                    return 'Debe empezar con 9.';
                  }

                  if (phone.length != 9) {
                    return 'Debe tener 9 dígitos.';
                  }

                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCountryCodeBox() {
    return Container(
      width: 54,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.23),
        ),
      ),
      child: Text(
        '+51',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 12.5,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget buildSmallAdvice({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8FA),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11.2,
                height: 1.3,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordTextHint() {
    return Text(
      'Debe incluir mayúscula, minúscula, número y símbolo.',
      style: TextStyle(
        fontSize: 10.5,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildInfoItem({required IconData icon, required String text}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 17, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11.3,
                height: 1.28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTermsCheck() {
    return Row(
      children: [
        Transform.scale(
          scale: 0.85,
          child: Checkbox(
            value: acceptTerms,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              setState(() {
                acceptTerms = value ?? false;
              });
            },
          ),
        ),
        const Expanded(
          child: Text(
            'Acepto los términos y condiciones.',
            style: TextStyle(fontSize: 11.2, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget buildLabeledInput({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.8,
            fontWeight: FontWeight.w800,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }

  Widget buildInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      validator: validator,
      textInputAction: TextInputAction.next,
      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),
      decoration: buildFieldDecoration(
        hint: hint,
        icon: icon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  InputDecoration buildFieldDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      prefixIcon: Icon(icon, size: 18),
      suffixIcon: suffixIcon,
      counterText: '',
      filled: true,
      fillColor: const Color(0xFFF3F4F8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: Colors.red.shade600, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: Colors.red.shade600, width: 1),
      ),
    );
  }

  Widget buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 43,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12.4,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class SideInfo {
  final String title;
  final String description;
  final IconData mainIcon;
  final IconData iconOne;
  final String textOne;
  final IconData iconTwo;
  final String textTwo;
  final IconData iconThree;
  final String textThree;

  const SideInfo({
    required this.title,
    required this.description,
    required this.mainIcon,
    required this.iconOne,
    required this.textOne,
    required this.iconTwo,
    required this.textTwo,
    required this.iconThree,
    required this.textThree,
  });
}
