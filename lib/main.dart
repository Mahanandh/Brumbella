import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_appliances_screen.dart';
import 'screens/consumer_electronics_screen.dart';
import 'screens/it_networking_screen.dart';
import 'screens/climate_control_screen.dart';
import 'screens/smart_home_screen.dart';
import 'screens/medical_health_screen.dart';
import 'screens/power_energy_screen.dart';
import 'screens/vehicles_mobility_screen.dart';
import 'screens/furniture_fixtures_screen.dart';
import 'screens/building_screen.dart';
import 'screens/manual_registration_screen.dart';

void main() {
  runApp(const BrumBellaApp());
}

class BrumBellaApp extends StatelessWidget {
  const BrumBellaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrumBella',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Container(
          color: const Color(0xFFE2E8F0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 24,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          ),
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF0F172A),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        cardTheme: const CardThemeData(
          surfaceTintColor: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A),
          primary: const Color(0xFF0F172A),
          secondary: const Color(0xFF059669),
          surface: Colors.white,
          background: const Color(0xFFF8FAFC),
        ),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: -0.5,
            color: const Color(0xFF0F172A),
          ),
          headlineMedium: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: -0.5,
            color: const Color(0xFF0F172A),
          ),
          titleMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0.2,
            color: const Color(0xFF64748B),
          ),
          bodyMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: const Color(0xFF334155),
          ),
          labelSmall: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 11,
            letterSpacing: 1.0,
            color: const Color(0xFF64748B),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: Color(0xFF0F172A), width: 1.0),
          ),
          hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF0F172A),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
            elevation: 0,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      home: const MainNavigationShell(),
    );
  }
}

/// Navigation manager that holds the state for authentication and active bottom tabs
class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  // Screens state: 'landing', 'login', 'register', 'dashboard'
  String _currentScreen = 'landing';
  int _currentTab = 0; // 0: Home, 1: Marketplace, 2: Scanner, 3: Settings

  void _navigateTo(String screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  void _changeTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    if (_currentScreen == 'landing') {
      screenWidget = LandingScreen(
        onLoginPressed: () => _navigateTo('login'),
        onCreateAccountPressed: () => _navigateTo('register'),
      );
    } else if (_currentScreen == 'login') {
      screenWidget = LoginScreen(
        onBackPressed: () => _navigateTo('landing'),
        onRequestOtpPressed: () => _navigateTo('dashboard'),
        onCreateAccountPressed: () => _navigateTo('register'),
      );
    } else if (_currentScreen == 'register') {
      screenWidget = RegisterScreen(
        onBackPressed: () => _navigateTo('landing'),
        onSendOtpPressed: () => _navigateTo('dashboard'),
        onSignInPressed: () => _navigateTo('login'),
      );
    } else {
      // Authenticated Dashboard view
      screenWidget = DashboardShell(
        currentTab: _currentTab,
        onTabChanged: _changeTab,
        onLogoutPressed: () {
          setState(() {
            _currentTab = 0;
            _currentScreen = 'landing';
          });
        },
      );
    }

    // Centered, responsive mobile-first shell
    return Scaffold(
      backgroundColor: const Color(0xFFE2E8F0),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
            ),
            child: screenWidget,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1. LANDING SCREEN
// ==========================================
class LandingScreen extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onCreateAccountPressed;

  const LandingScreen({
    super.key,
    required this.onLoginPressed,
    required this.onCreateAccountPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.0,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 12),
            RichText(
              text: TextSpan(
                text: 'Brum',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
                children: [
                  TextSpan(
                    text: 'Bella',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF059669),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'All your products, digitally organized.',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Say goodbye to lost receipts, paper manuals, and expired warranties. Scan any product to instantly add it to your digital vault.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFF64748B),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildFeatureCard(
                          icon: Icons.inventory_2_outlined,
                          title: '1-Tap Registration',
                          subtitle: 'Scan a QR code to instantly sync your item.',
                        ),
                        const SizedBox(width: 16),
                        _buildFeatureCard(
                          icon: Icons.shield_outlined,
                          title: 'Track Warranties',
                          subtitle: 'Get alerts before your coverage expires.',
                        ),
                        const SizedBox(width: 16),
                        _buildFeatureCard(
                          icon: Icons.build_outlined,
                          title: 'Easy Repairs',
                          subtitle: 'Book verified service with one click.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    'How it works',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildStepItem(
                    step: 1,
                    icon: Icons.camera_alt_outlined,
                    text: 'Scan the code on your product.',
                  ),
                  const SizedBox(height: 16),
                  _buildStepItem(
                    step: 2,
                    icon: Icons.cloud_sync_outlined,
                    text: 'We fetch the manuals and warranty.',
                  ),
                  const SizedBox(height: 16),
                  _buildStepItem(
                    step: 3,
                    icon: Icons.phone_iphone_outlined,
                    text: 'Manage everything in one place.',
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                border: Border(
                  top: BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: onCreateAccountPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF059669),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: onLoginPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF64748B),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: Text(
                      'I already have an account. Log in.',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFECFDF5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF059669), size: 28),
          ),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required int step,
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Icon(icon, color: const Color(0xFF0F172A), size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF334155),
            ),
          ),
        ),
      ],
    );
  }
}


// ==========================================
// 2. LOGIN & ACCESS SCREEN
// ==========================================
class LoginScreen extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onRequestOtpPressed;
  final VoidCallback onCreateAccountPressed;

  const LoginScreen({
    super.key,
    required this.onBackPressed,
    required this.onRequestOtpPressed,
    required this.onCreateAccountPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Line
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: onBackPressed,
                icon: const Icon(Icons.arrow_back, size: 16, color: Color(0xFF64748B)),
                label: const Text(
                  'Back',
                  style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
              const Text(
                'STEP 1 / 2',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFFF1F5F9), height: 1),

        // Main Login Card area
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Shield outline indicator
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shield_outlined,
                        color: Color(0xFF059669),
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Continue with your BrumBella account.',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Phone or Email Label
                    const Text(
                      'PHONE OR EMAIL',
                      style: TextStyle(
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'you@example.com',
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Request OTP action
                    ElevatedButton(
                      onPressed: onRequestOtpPressed,
                      child: const Text('Request OTP'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Footer Redirect
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'New to BrumBella? ',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
              ),
              GestureDetector(
                onTap: onCreateAccountPressed,
                child: const Text(
                  'Create an account',
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 3. ACCOUNT REGISTRATION SCREEN
// ==========================================
class RegisterScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onSendOtpPressed;
  final VoidCallback onSignInPressed;

  const RegisterScreen({
    super.key,
    required this.onBackPressed,
    required this.onSendOtpPressed,
    required this.onSignInPressed,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Toggle Selection: 'consumer' or 'partner'
  String _accountType = 'consumer';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: widget.onBackPressed,
                icon: const Icon(Icons.arrow_back, size: 16, color: Color(0xFF64748B)),
                label: const Text(
                  'Back',
                  style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
              const Text(
                'CREATE ACCOUNT',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFFF1F5F9), height: 1),

        // Scrollable input forms
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Get started',
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Provision your BrumBella workspace in under a minute.',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 28),

                // Name input
                const Text(
                  'FULL NAME',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Jane Doe',
                    prefixIcon: Icon(Icons.person_outline, color: Color(0xFF94A3B8)),
                  ),
                ),
                const SizedBox(height: 20),

                // Email input
                const Text(
                  'EMAIL',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'jane@example.com',
                    prefixIcon: Icon(Icons.mail_outline, color: Color(0xFF94A3B8)),
                  ),
                ),
                const SizedBox(height: 20),

                // Phone number input
                const Text(
                  'PHONE NUMBER',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: '+1 555 123 4567',
                    prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFF94A3B8)),
                  ),
                ),
                const SizedBox(height: 24),

                // Account Selection Toggle Widget
                const Text(
                  'ACCOUNT TYPE',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _accountType = 'consumer'),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _accountType == 'consumer'
                                  ? const Color(0xFF0F172A)
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(7),
                              ),
                            ),
                            child: Text(
                              'Consumer',
                              style: TextStyle(
                                color: _accountType == 'consumer'
                                    ? Colors.white
                                    : const Color(0xFF64748B),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _accountType = 'partner'),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _accountType == 'partner'
                                  ? const Color(0xFF0F172A)
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(7),
                              ),
                            ),
                            child: Text(
                              'Service Partner',
                              style: TextStyle(
                                color: _accountType == 'partner'
                                    ? Colors.white
                                    : const Color(0xFF64748B),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Submit Send OTP
                ElevatedButton(
                  onPressed: widget.onSendOtpPressed,
                  child: const Text('Send OTP'),
                ),
              ],
            ),
          ),
        ),

        // Footer Redirect
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already a member? ',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
              ),
              GestureDetector(
                onTap: widget.onSignInPressed,
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 4. AUTHENTICATED DASHBOARD SHELL
// ==========================================
class DashboardShell extends StatelessWidget {
  final int currentTab;
  final ValueChanged<int> onTabChanged;
  final VoidCallback onLogoutPressed;

  const DashboardShell({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    Widget activeView;

    switch (currentTab) {
      case 0:
        activeView = const DashboardHomeView();
        break;
      case 1:
        activeView = const MarketplaceView();
        break;
      case 2:
        activeView = const MockScannerView();
        break;
      case 3:
        activeView = const CopilotScreen();
        break;
      case 4:
        activeView = SettingsView(onLogoutPressed: onLogoutPressed);
        break;
      default:
        activeView = const DashboardHomeView();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: activeView,
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTabChanged(2), // Scanner
        backgroundColor: const Color(0xFF059669),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
            SizedBox(width: 4),
            Icon(Icons.keyboard_alt_outlined, color: Colors.white, size: 20),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBottomTab(0, Icons.home_outlined, 'Home'),
            _buildBottomTab(1, Icons.storefront_outlined, 'Market'),
            const SizedBox(width: 48), // Space for FAB
            _buildBottomTab(3, Icons.auto_awesome_outlined, 'Copilot'),
            _buildBottomTab(4, Icons.settings_outlined, 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomTab(int index, IconData icon, String label) {
    final bool isActive = currentTab == index;
    final color = isActive ? const Color(0xFF059669) : const Color(0xFF64748B);

    return InkWell(
      onTap: () => onTabChanged(index),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------
// D-1. COPILOT SCREEN (AI SUPPORT)
// ------------------------------------------
class CopilotScreen extends StatelessWidget {
  const CopilotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          color: const Color(0xFFF8FAFC),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Support Copilot',
                      style: GoogleFonts.manrope(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF059669),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Connected to digital manuals',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Icon(Icons.history, color: Color(0xFF64748B), size: 20),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE2E8F0)),

        // Chat Area
        Expanded(
          child: Container(
            color: const Color(0xFFF8FAFC),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // AI Avatar + Greeting Bubble
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            'Hi User, I\'m your BrumBella Copilot. I have loaded the manuals for your Smart Water Flosser and Smart Fitness Watch. How can I help you today?',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: const Color(0xFF334155),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Suggestion Chips
                  Text(
                    'SUGGESTIONS',
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildSuggestionChip('How do I clean the AquaPro X2?'),
                        const SizedBox(width: 8),
                        _buildSuggestionChip('Check my RO Purifier warranty'),
                        const SizedBox(width: 8),
                        _buildSuggestionChip('Order replacement filters'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Capabilities Section
                  Text(
                    'CAPABILITIES',
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCapabilityItem(
                    Icons.menu_book_outlined,
                    'Manual Retrieval',
                    'Instantly search through your product manuals',
                  ),
                  const SizedBox(height: 8),
                  _buildCapabilityItem(
                    Icons.build_outlined,
                    'Troubleshooting',
                    'Step-by-step diagnostic assistance',
                  ),
                  const SizedBox(height: 8),
                  _buildCapabilityItem(
                    Icons.shopping_bag_outlined,
                    'Parts & Ordering',
                    'Find and order replacement components',
                  ),
                  const SizedBox(height: 100), // Pushes the last card completely above the navigation bar
                ],
              ),
            ),
          ),
        ),

        // Input Area
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 80),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ask about your registered products...',
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF94A3B8),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(right: 4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF059669),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send, color: Colors.white, size: 18),
                      ),
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

  Widget _buildSuggestionChip(String text) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF334155),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        minimumSize: const Size(0, 36),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildCapabilityItem(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF059669), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFCBD5E1), size: 20),
        ],
      ),
    );
  }
}

// ------------------------------------------
// D-2. POST-AUTHENTICATION DASHBOARD (HOME)
// ------------------------------------------
class DashboardHomeView extends StatefulWidget {
  const DashboardHomeView({super.key});

  @override
  State<DashboardHomeView> createState() => _DashboardHomeViewState();
}

class _DashboardHomeViewState extends State<DashboardHomeView> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Premium Workspace Identification Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(width: 12),
                      RichText(
                        text: TextSpan(
                          text: 'Brum',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                          children: [
                            TextSpan(
                              text: 'Bella',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF059669),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hello, User',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF64748B),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                    ),
                    child: const Icon(
                      Icons.notifications_none_outlined,
                      color: Color(0xFF475569),
                      size: 24,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF059669), // Brand Green
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 1.5)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFFF1F5F9), height: 1),

        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0).copyWith(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Integrated Asset Ingestion Panel
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF0F172A)),
                    label: Text(
                      'Scan QR Code',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 52),
                      side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: const Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                        ),
                        child: TextField(
                          style: GoogleFonts.inter(fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'Enter Serial Number',
                            hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(120, 52),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        'Ingest Asset',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManualRegistrationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Don't have a code or serial? Register manually.",
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF059669)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Category Discovery Grid
                Text(
                  'DISCOVER CATEGORIES',
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                  children: [
                    _buildDiscoveryCategoryCard('Home Appliances', Icons.home_max_outlined, imageAsset: 'assets/images/home_appliances_logo.png'),
                    _buildDiscoveryCategoryCard('Consumer Electronics', Icons.devices_other_outlined, imageAsset: 'assets/images/consumer_electronics_logo.png'),
                    _buildDiscoveryCategoryCard('IT & Networking Infrastructure', Icons.router_outlined, imageAsset: 'assets/images/it_networking_logo.png'),
                    _buildDiscoveryCategoryCard('Climate Control', Icons.ac_unit_outlined, imageAsset: 'assets/images/climate_control_logo.png'),
                    _buildDiscoveryCategoryCard('Smart Home & Security', Icons.security_outlined, imageAsset: 'assets/images/smart_home_logo.png'),
                    _buildDiscoveryCategoryCard('Medical & Health Equipment', Icons.health_and_safety_outlined, imageAsset: 'assets/images/medical_health_logo.png'),
                    _buildDiscoveryCategoryCard('Power & Energy Systems', Icons.solar_power_outlined, imageAsset: 'assets/images/power_energy_logo.png'),
                    _buildDiscoveryCategoryCard('Vehicles & Mobility', Icons.electric_car_outlined, imageAsset: 'assets/images/vehicles_mobility_logo.png'),
                    _buildDiscoveryCategoryCard('Furniture & Fixtures', Icons.weekend_outlined, imageAsset: 'assets/images/furniture_logo.png'),
                    _buildDiscoveryCategoryCard('Building', Icons.apartment_outlined, imageAsset: 'assets/images/building_logo.png'),
                  ],
                ),
                const SizedBox(height: 32),

                // Asset Registry Inventory List
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'REGISTERED ASSETS',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF64748B),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'View all',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF059669),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    if (_selectedCategory == 'All' || _selectedCategory == 'Home Appliances')
                      _buildAssetRecord(
                        icon: Icons.water_drop_outlined,
                        title: 'Smart Water Flosser',
                        subtitle: 'Model · AquaPro X2  •  AQ2-00481',
                        status: 'ACTIVE',
                      ),
                    if (_selectedCategory == 'All' || _selectedCategory == 'Home Appliances')
                      _buildAssetRecord(
                        icon: Icons.air_outlined,
                        title: 'RO Water Purifier',
                        subtitle: 'Model · PureFlow 9L  •  PF9-12090',
                        status: 'EXPIRING',
                      ),
                    if (_selectedCategory == 'All' || _selectedCategory == 'Smart Wearables')
                      _buildAssetRecord(
                        icon: Icons.watch_outlined,
                        title: 'Smart Fitness Watch',
                        subtitle: 'Model · PulseTrack 4  •  PT4-77231',
                        status: 'ACTIVE',
                      ),
                    if (_selectedCategory == 'All' || _selectedCategory == 'Medical & Health')
                      _buildAssetRecord(
                        icon: Icons.monitor_heart_outlined,
                        title: 'Digital BP Monitor',
                        subtitle: 'Model · CardioSense M2  •  CS2-30118',
                        status: 'EXPIRED',
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildAssetRecord({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
  }) {
    Color statusBgColor;
    Color statusTextColor;

    if (status == 'ACTIVE') {
      statusBgColor = const Color(0xFFECFDF5); // emerald[50]
      statusTextColor = const Color(0xFF047857); // emerald[700]
    } else if (status == 'EXPIRING') {
      statusBgColor = const Color(0xFFFFF7ED); // orange[50]
      statusTextColor = const Color(0xFFC2410C); // orange[700]
    } else {
      statusBgColor = const Color(0xFFFEF2F2); // red[50]
      statusTextColor = const Color(0xFFB91C1C); // red[700]
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Icon(icon, color: const Color(0xFF475569), size: 20),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            color: const Color(0xFF64748B),
            fontSize: 12,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: statusBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: GoogleFonts.inter(
              color: statusTextColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoveryCategoryCard(String title, IconData icon, {String? imageAsset}) {
    return Card(
      color: const Color(0xFFFFFFFF),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = title;
          });
          if (title == 'Home Appliances') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeAppliancesScreen(),
              ),
            );
          } else if (title == 'Consumer Electronics') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConsumerElectronicsScreen(),
              ),
            );
          } else if (title == 'IT & Networking Infrastructure') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ItNetworkingScreen()),
            );
          } else if (title == 'Climate Control') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClimateControlScreen()),
            );
          } else if (title == 'Smart Home & Security') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SmartHomeScreen()),
            );
          } else if (title == 'Medical & Health Equipment') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MedicalHealthScreen()),
            );
          } else if (title == 'Power & Energy Systems') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PowerEnergyScreen()),
            );
          } else if (title == 'Vehicles & Mobility') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VehiclesMobilityScreen()),
            );
          } else if (title == 'Furniture & Fixtures') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FurnitureFixturesScreen()),
            );
          } else if (title == 'Building') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BuildingScreen()),
            );
          }
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageAsset != null)
              Image.asset(
                imageAsset,
                height: 56.0,
                width: 56.0,
                fit: BoxFit.contain,
              )
            else
              Icon(icon, color: const Color(0xFF64748B), size: 28),
            if (imageAsset == null) const SizedBox(height: 8),
            Transform.translate(
              offset: Offset(0, imageAsset != null ? -8.0 : 0.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------
// E. AFTER-SALES MARKETPLACE VIEW
// ------------------------------------------
class MarketplaceView extends StatelessWidget {
  const MarketplaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Bar Header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AFTER-SALES',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Marketplace',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Curated services, parts, and coverage for registered assets.',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFFF1F5F9), height: 1),

        // Marketplace Matrix Stacks
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SEGMENTS',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                  ),
                  child: Column(
                    children: [
                      _buildMarketSegmentTile(
                        icon: Icons.handyman_outlined,
                        title: 'Service Partners',
                        description: 'Verified OEM-authorized technicians',
                        token: '128 listed',
                      ),
                      const Divider(color: Color(0xFFF1F5F9), height: 1),
                      _buildMarketSegmentTile(
                        icon: Icons.inventory_2_outlined,
                        title: 'OEM Spare Parts',
                        description: 'Genuine components & consumables',
                        token: '2,410 SKUs',
                      ),
                      const Divider(color: Color(0xFFF1F5F9), height: 1),
                      _buildMarketSegmentTile(
                        icon: Icons.local_shipping_outlined,
                        title: 'Logistics & Pickup',
                        description: 'Scheduled returns and replacements',
                        token: 'On-demand',
                      ),
                      const Divider(color: Color(0xFFF1F5F9), height: 1),
                      _buildMarketSegmentTile(
                        icon: Icons.security_outlined,
                        title: 'Extended Warranty',
                        description: 'Coverage plans beyond OEM terms',
                        token: '4 tiers',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Availability Notification Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Catalog availability',
                              style: TextStyle(
                                color: Color(0xFF0F172A),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Full marketplace activates after your first asset registration.',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'PROVISIONING',
                          style: TextStyle(
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
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
      ],
    );
  }

  Widget _buildMarketSegmentTile({
    required IconData icon,
    required String title,
    required String description,
    required String token,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Icon(icon, color: const Color(0xFF475569), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        description,
        style: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 11,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            token,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Color(0xFF94A3B8), size: 16),
        ],
      ),
    );
  }
}

// ------------------------------------------
// F. CONFIGURATION SETTINGS SCREEN
// ------------------------------------------
class SettingsView extends StatelessWidget {
  final VoidCallback onLogoutPressed;

  const SettingsView({
    super.key,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONFIGURATION',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Settings',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFFF1F5F9), height: 1),

        // Main Settings Options List
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Metadata Identification Block
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0xFF0F172A),
                        child: Text(
                          'JD',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jane Doe',
                              style: TextStyle(
                                color: Color(0xFF0F172A),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'jane@example.com',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'CONSUMER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ACCOUNT MENU CARD
                _buildSectionHeader('ACCOUNT'),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                  ),
                  child: Column(
                    children: [
                      _buildMenuRow(Icons.person_outline, 'Profile', 'Jane Doe'),
                      const Divider(color: Color(0xFFF1F5F9), height: 1),
                      _buildMenuRow(Icons.vpn_key_outlined, 'Authentication', 'OTP enabled'),
                      const Divider(color: Color(0xFFF1F5F9), height: 1),
                      _buildMenuRow(Icons.notifications_none_outlined, 'Notifications', 'Email â€¢ Push'),
                      const Divider(color: Color(0xFFF1F5F9), height: 1),
                      _buildMenuRow(Icons.security_outlined, 'Privacy & Security', 'Standard'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // WORKSPACE MENU CARD
                _buildSectionHeader('WORKSPACE'),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Column(
                    children: [
                      _buildMenuRow(Icons.language_outlined, 'Region & Language', 'EN-US'),
                      const Divider(color: Color(0xFFF1F5F9), height: 1),
                      _buildMenuRow(Icons.list_alt_outlined, 'Audit Logs', '30 days'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // SUPPORT MENU CARD
                _buildSectionHeader('SUPPORT'),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: _buildMenuRow(Icons.help_outline, 'Help Center', ''),
                ),
                const SizedBox(height: 32),

                // Log out Button
                OutlinedButton(
                  onPressed: onLogoutPressed,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFCA5A5)),
                    foregroundColor: const Color(0xFFEF4444),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Log out',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Prevent FAB occlusion
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 20),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          if (value.isNotEmpty)
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Color(0xFF94A3B8), size: 16),
        ],
      ),
    );
  }
}

// ------------------------------------------
// MOCK VIEW: SCANNER
// ------------------------------------------
class MockScannerView extends StatelessWidget {
  const MockScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F172A), // Dark scan background
      child: Column(
        children: [
          // Scanner View Top Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OPTICAL SCANNER',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Live Camera',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.flash_on, color: Colors.amber, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'FLASH OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF1E293B), height: 1),

          // Central Camera Viewport Mock
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Viewport Scanner Frame box
                    Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF059669), width: 3),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 200,
                              height: 1,
                              color: const Color(0xFFEF4444), // Scanning red line
                            ),
                          ),
                          const Positioned(
                            top: 10,
                            left: 10,
                            child: Icon(Icons.crop_free_outlined, color: Colors.white24, size: 30),
                          ),
                          const Positioned(
                            bottom: 10,
                            right: 10,
                            child: Icon(Icons.crop_free_outlined, color: Colors.white24, size: 30),
                          ),
                          Center(
                            child: Icon(
                              Icons.qr_code_scanner,
                              color: Colors.white.withOpacity(0.1),
                              size: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Position tag inside the box framework to read',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Supports QR, NFC, and manual fallback coding',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Manual Entry fallback bottom drawer bar
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'MANUAL SERIAL ENTRY',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF334155)),
                        ),
                        child: const TextField(
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Enter serial number manually',
                            hintStyle: TextStyle(color: Color(0xFF475569)),
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF059669),
                        minimumSize: const Size(80, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
