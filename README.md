# Blood Wanka 🩸

Aplicación móvil orientada a conectar donantes de sangre con pacientes e instituciones médicas de forma rápida y segura. Proyecto desarrollado para el curso de Desarrollo de Aplicaciones Móviles (X Semestre) de la Universidad Nacional del Centro del Perú (UNCP).

## 🏛 Arquitectura del Proyecto

Este proyecto utiliza una **Arquitectura Orientada a Funcionalidades (Feature-First)** para evitar conflictos de código en Git. Cada desarrollador tiene una carpeta asignada dentro de `lib/features/` y una rama específica en el repositorio.

Al iniciar la aplicación (`flutter run`), se mostrará un **Menú de Desarrollo**. Cada miembro del equipo debe hacer clic en su respectivo botón para ingresar a su entorno de trabajo aislado.

## 👥 Equipo de Desarrollo y Asignaciones

| Desarrollador | Módulo | Rama de Git | Archivo Principal de Trabajo |
| :--- | :--- | :--- | :--- |
| **Quispe Ortiz** | Login | `feature/login` | `lib/features/login/login_screen.dart` |
| **Macha Pariona** | Autenticación | `feature/auth` | `lib/features/auth/auth_screen.dart` |
| **Jhordan Armando Huaman Rojas** | Principal (Home) | `feature/home` | `lib/features/home/home_screen.dart` |
| **Janampa** | Buscar Donante | `feature/search_donor` | `lib/features/search_donor/search_donor_screen.dart` |

## ⚠️ Reglas Estrictas del Equipo

1. **NO modificar `main.dart` ni `app_routes.dart`**. El enrutamiento ya está configurado.
2. **Uso de Colores:** No escribas códigos hexadecimales (como el rojo) a mano. El tema global ya está configurado. Usa `Theme.of(context).primaryColor`.
3. **Componentes Locales:** Si necesitas un widget específico para tu pantalla, crea una carpeta `widgets/` dentro de tu propia funcionalidad (ej. `lib/features/login/widgets/`).
4. **Trabaja solo en tu rama:** Nunca hagas commits directamente en `main`.

## 🚀 Pasos para empezar a programar

Sigue estos comandos en tu terminal para obtener el proyecto y empezar a trabajar:

```bash
# 1. Clonar el repositorio
git clone [https://github.com/Jhordan21-H/blood_wanka.git](https://github.com/Jhordan21-H/blood_wanka.git)

# 2. Entrar a la carpeta del proyecto
cd blood_wanka

# 3. Sincronizar las ramas
git fetch origin

# 4. Cambiarte a tu rama asignada (Ejemplo para Login)
git checkout feature/login

# 5. Instalar dependencias y correr el proyecto
flutter pub get
flutter run