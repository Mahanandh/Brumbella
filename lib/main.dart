import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF0F172A),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false,
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
    final theme = Theme.of(context);

    return Column(
      children: [
        // Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Brum',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: const Color(0xFF0F172A),
                        fontWeight: FontWeight.w900,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Bella',
                          style: TextStyle(
                            color: Color(0xFF059669),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'One Product · One Identity · One Platform',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'v1.0',
                  style: TextStyle(
                    color: Color(0xFF065F46),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFFF1F5F9), height: 1),

        // Content Scroll Area
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero presentation block
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'UNIFIED CLOUD',
                    style: TextStyle(
                      color: Color(0xFF059669),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'One SaaS platform connecting customers, enterprises, and developers through a single intelligent cloud.',
                  style: theme.textTheme.headlineLarge,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Replace physical warranty cards, manuals, and service history with a universal digital layer.',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Industry segment matrix container
                const Text(
                  'BUILT FOR EVERY INDUSTRY',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x050F172A),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildIndustryTile(
                        icon: Icons.phone_android_outlined,
                        title: 'Consumer Electronics',
                        tag: 'B2C',
                      ),
                      const Divider(color: Color(0xFFF1F5F9), height: 1),
                      _buildIndustryTile(
                        icon: Icons.favorite_border,
                        title: 'Medical Devices',
                        tag: 'Regulated',
                      ),
                      const Divider(color: Color(0xFFF1F5F9), height: 1),
                      _buildIndustryTile(
                        icon: Icons.business_outlined,
                        title: 'Institute / Office',
                        tag: 'B2B',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Navigation Actions
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: onLoginPressed,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onCreateAccountPressed,
                child: const Text('Create account'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIndustryTile({
    required IconData icon,
    required String title,
    required String tag,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF475569), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      trailing: Text(
        tag,
        style: const TextStyle(
          color: Color(0xFF94A3B8),
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
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
        activeView = SettingsView(onLogoutPressed: onLogoutPressed);
        break;
      default:
        activeView = const DashboardHomeView();
    }

    return Column(
      children: [
        // Main view content
        Expanded(child: activeView),

        // Custom Bottom Navigation Bar with top active indicator line
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Color(0xFFF1F5F9), width: 1),
            ),
          ),
          child: Row(
            children: [
              _buildBottomTab(0, Icons.home_outlined, 'Home'),
              _buildBottomTab(1, Icons.storefront_outlined, 'Marketplace'),
              _buildBottomTab(2, Icons.qr_code_scanner_outlined, 'Scanner'),
              _buildBottomTab(3, Icons.settings_outlined, 'Settings'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomTab(int index, IconData icon, String label) {
    final bool isActive = currentTab == index;
    final color = isActive ? const Color(0xFF059669) : const Color(0xFF64748B);

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isActive ? const Color(0xFF059669) : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 2),
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
      ),
    );
  }
}

// ------------------------------------------
// D. POST-AUTHENTICATION DASHBOARD (HOME)
// ------------------------------------------
class DashboardHomeView extends StatelessWidget {
  const DashboardHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Workspace Identification Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WORKSPACE',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Hello, Jane',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
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
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                    ),
                    child: const Icon(
                      Icons.notifications_none_outlined,
                      color: Color(0xFF475569),
                      size: 22,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF34D399),
                        shape: BoxShape.circle,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Asset Registration Tracking Bar
                const Text(
                  'REGISTER ASSET',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.crop_free, color: Color(0xFF64748B), size: 20),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Scan QR / NFC, or enter serial manually',
                                  filled: false,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 46,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0F172A),
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(80, 46),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                          ),
                        ),
                        child: const Text('Validate'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  '• Fallback redundancy: manual entry honored when optical scan fails.',
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),

                // AI Engine Console Panel Module
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B132B),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'brumbella://engine/rag · connected',
                                style: TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 11,
                                  fontFamily: 'Courier',
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.developer_board_outlined,
                            color: Color(0xFF64748B),
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: const TextSpan(
                          text: 'BrumBella Enterprise Engine: ',
                          style: TextStyle(
                            color: Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: 'Connected to localized product manuals & hardware service schema history via semantic retrieval.',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {},
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Open copilot',
                              style: TextStyle(
                                color: Color(0xFF10B981),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, color: Color(0xFF10B981), size: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Operational Telemetry Analytics Matrix
                const Text(
                  'OPERATIONAL TELEMETRY',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.25,
                  children: [
                    _buildTelemetryCard(
                      icon: Icons.shield_outlined,
                      title: 'Active Asset Registry Coverage',
                      value: '4 Units',
                      footer: 'Warranties',
                    ),
                    _buildTelemetryCard(
                      icon: Icons.handyman_outlined,
                      title: 'Open Service Log Tickets',
                      value: '1 Open',
                      footer: 'Service Requests',
                    ),
                    _buildTelemetryCard(
                      icon: Icons.inventory_2_outlined,
                      title: 'Compatible Inventory Maps',
                      value: 'Verified',
                      footer: 'Spare Parts',
                    ),
                    _buildTelemetryCard(
                      icon: Icons.person_search_outlined,
                      title: 'Telemetry Optimization Index',
                      value: '98%',
                      footer: 'Usage Profiles',
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Asset Registry Inventory List
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'REGISTERED ASSETS',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'View all',
                        style: TextStyle(
                          color: Color(0xFF059669),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    _buildAssetRecord(
                      icon: Icons.water_drop_outlined,
                      title: 'Smart Water Flosser',
                      subtitle: 'Model · AquaPro X2  •  AQ2-00481',
                      status: 'ACTIVE',
                    ),
                    _buildAssetRecord(
                      icon: Icons.air_outlined,
                      title: 'RO Water Purifier',
                      subtitle: 'Model · PureFlow 9L  •  PF9-12090',
                      status: 'EXPIRING',
                    ),
                    _buildAssetRecord(
                      icon: Icons.watch_outlined,
                      title: 'Smart Fitness Watch',
                      subtitle: 'Model · PulseTrack 4  •  PT4-77231',
                      status: 'ACTIVE',
                    ),
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

  Widget _buildTelemetryCard({
    required IconData icon,
    required String title,
    required String value,
    required String footer,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: const Color(0xFF64748B), size: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    footer,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'LIVE',
                style: TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
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
      statusBgColor = const Color(0xFF059669).withOpacity(0.1);
      statusTextColor = const Color(0xFF064E3B);
    } else if (status == 'EXPIRING') {
      statusBgColor = const Color(0xFFD97706).withOpacity(0.1);
      statusTextColor = const Color(0xFF78350F);
    } else {
      statusBgColor = const Color(0xFF64748B).withOpacity(0.1);
      statusTextColor = const Color(0xFF0F172A);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
      ),
      child: ListTile(
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
          subtitle,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 11,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusBgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status.toUpperCase(),
            style: TextStyle(
              color: statusTextColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
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
            padding: const EdgeInsets.all(16),
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
                      _buildMenuRow(Icons.notifications_none_outlined, 'Notifications', 'Email • Push'),
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
