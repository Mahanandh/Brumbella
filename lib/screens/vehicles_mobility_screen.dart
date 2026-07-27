import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_list_card.dart';
import 'device_detail_screen.dart';
import 'manual_registration_screen.dart';

class VehiclesMobilityScreen extends StatelessWidget {
  const VehiclesMobilityScreen({super.key});

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
          'Vehicles & Mobility',
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
                    prefilledCategory: 'Vehicles & Mobility',
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
              context, 'Electric Scooters', Icons.electric_scooter_outlined),
          _buildSubCategoryCard(context, 'Bicycles', Icons.pedal_bike_outlined),
          _buildSubCategoryCard(context, 'Cars', Icons.directions_car_outlined),
          _buildSubCategoryCard(
              context, 'Commercial Fleet Vans', Icons.local_shipping_outlined),
        ],
      ),
    );
  }

  Widget _buildSubCategoryCard(
      BuildContext context, String title, IconData icon) {
    return PremiumListCard(
      title: title,
      icon: icon,
      themeColor: const Color(0xFF00B09B),
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
