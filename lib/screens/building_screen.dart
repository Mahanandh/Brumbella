import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_list_card.dart';
import 'device_detail_screen.dart';
import 'manual_registration_screen.dart';

class BuildingScreen extends StatelessWidget {
  const BuildingScreen({super.key});

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
          'Building',
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
                    prefilledCategory: 'Building',
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
              context, 'Power Drills', Icons.build_circle_outlined),
          _buildSubCategoryCard(
              context, 'Air Compressors', Icons.compress_outlined),
          _buildSubCategoryCard(
              context, 'Concrete Mixers', Icons.construction_outlined),
          _buildSubCategoryCard(
              context, 'Welding Machines', Icons.hardware_outlined),
          _buildSubCategoryCard(
              context, 'Industrial Saws', Icons.carpenter_outlined),
          _buildSubCategoryCard(
              context, 'CCTV Camera Systems', Icons.videocam_outlined),
          _buildSubCategoryCard(
              context, 'Smart Door Locks', Icons.lock_outline),
          _buildSubCategoryCard(
              context, 'Video Doorbells', Icons.doorbell_outlined),
          _buildSubCategoryCard(
              context, 'Automated Thermostats', Icons.thermostat_outlined),
          _buildSubCategoryCard(
              context, 'Smoke Detectors', Icons.sensors_outlined),
        ],
      ),
    );
  }

  Widget _buildSubCategoryCard(
      BuildContext context, String title, IconData icon) {
    return PremiumListCard(
      title: title,
      icon: icon,
      themeColor: const Color(0xFF43C6AC),
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
