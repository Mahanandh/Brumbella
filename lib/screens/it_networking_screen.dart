import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_list_card.dart';
import 'device_detail_screen.dart';
import 'manual_registration_screen.dart';

class ItNetworkingScreen extends StatelessWidget {
  const ItNetworkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
        title: Text(
          'IT & Networking Infrastructure',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.add_circle_outline, color: Color(0xFF0F172A)),
            tooltip: 'Register New Device',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManualRegistrationScreen(
                    prefilledCategory: 'IT & Networking Infrastructure',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSubCategoryCard(
              context, 'Enterprise Servers', Icons.dns_outlined),
          _buildSubCategoryCard(
              context, 'Wi-Fi Routers', Icons.router_outlined),
          _buildSubCategoryCard(
              context, 'Office Printers/Copiers', Icons.print_outlined),
          _buildSubCategoryCard(
              context, 'Network Switches', Icons.settings_ethernet_outlined),
          _buildSubCategoryCard(
              context, 'Conference Projectors', Icons.videocam_outlined),
        ],
      ),
    );
  }

  Widget _buildSubCategoryCard(
      BuildContext context, String title, IconData icon) {
    return PremiumListCard(
      title: title,
      icon: icon,
      themeColor: const Color(0xFF11998E),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetailScreen(categoryName: title),
          ),
        );
      },
    );
  }
}
