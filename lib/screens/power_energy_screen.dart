import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_list_card.dart';
import 'device_detail_screen.dart';
import 'manual_registration_screen.dart';

class PowerEnergyScreen extends StatelessWidget {
  const PowerEnergyScreen({super.key});

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
          'Electrical System',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF0F172A)),
            tooltip: 'Register New Device',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManualRegistrationScreen(
                    prefilledCategory: 'Electrical System',
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
          _buildSubCategoryCard(context, 'Solar Inverters', Icons.solar_power_outlined),
          _buildSubCategoryCard(context, 'Home UPS Battery Systems', Icons.battery_charging_full_outlined),
          _buildSubCategoryCard(context, 'Portable Generators', Icons.power_outlined),
          _buildSubCategoryCard(context, 'EV Charging Stations', Icons.ev_station_outlined),
          _buildSubCategoryCard(context, 'Electrical Lights & Bulbs', Icons.lightbulb_outline),
          _buildSubCategoryCard(context, 'Smart Plugs & Outlets', Icons.outlet),
          _buildSubCategoryCard(context, 'Power Strips & Extension Cords', Icons.electrical_services),
          _buildSubCategoryCard(context, 'Switches & Dimmers', Icons.toggle_on),
          _buildSubCategoryCard(context, 'Circuit Breakers & Fuses', Icons.offline_bolt),
        ],
      ),
    );
  }

  Widget _buildSubCategoryCard(BuildContext context, String title, IconData icon) {
    return PremiumListCard(
      title: title,
      icon: icon,
      themeColor: const Color(0xFFFDC830),
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
