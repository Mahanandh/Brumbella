import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/premium_list_card.dart';
import 'device_detail_screen.dart';
import 'manual_registration_screen.dart';

class HomeAppliancesScreen extends StatelessWidget {
  const HomeAppliancesScreen({super.key});

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
          'Home Appliances',
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
                    prefilledCategory: 'Home Appliances',
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
          _buildSubCategoryCard(context, 'Washing Machines', Icons.local_laundry_service_outlined),
          _buildSubCategoryCard(context, 'Air Conditioners', Icons.ac_unit_outlined),
          _buildSubCategoryCard(context, 'Smart Televisions', Icons.tv_outlined),
          _buildSubCategoryCard(context, 'Vacuum Cleaners', Icons.cleaning_services_outlined),
          _buildSubCategoryCard(context, 'Room Air Purifiers', Icons.air_outlined),
          _buildSubCategoryCard(context, 'Ceiling Fans', Icons.wind_power),
          _buildSubCategoryCard(context, 'Water Heaters', Icons.water_drop),
          _buildSubCategoryCard(context, 'Irons', Icons.iron),
          _buildSubCategoryCard(context, 'Sewing Machines', Icons.design_services),
        ],
      ),
    );
  }

  Widget _buildSubCategoryCard(BuildContext context, String title, IconData icon) {
    return PremiumListCard(
      title: title,
      icon: icon,
      themeColor: const Color(0xFF0072FF),
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
