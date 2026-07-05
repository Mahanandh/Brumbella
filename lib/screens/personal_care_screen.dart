import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/premium_list_card.dart';
import 'device_detail_screen.dart';
import 'manual_registration_screen.dart';

class PersonalCareScreen extends StatelessWidget {
  const PersonalCareScreen({super.key});

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
          'Personal Care',
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
                    prefilledCategory: 'Personal Care',
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
          _buildSubCategoryCard(context, 'Beard Trimmers', Icons.content_cut),
          _buildSubCategoryCard(context, 'Hair Dryers & Styling', Icons.air),
          _buildSubCategoryCard(context, 'Cosmetics & Makeup', Icons.brush),
          _buildSubCategoryCard(context, 'Eye Makeup', Icons.remove_red_eye),
          _buildSubCategoryCard(context, 'Daily Skincare', Icons.water_drop),
          _buildSubCategoryCard(context, 'Sunscreens & SPF', Icons.wb_sunny),
        ],
      ),
    );
  }

  Widget _buildSubCategoryCard(BuildContext context, String title, IconData icon) {
    return PremiumListCard(
      title: title,
      icon: icon,
      themeColor: Colors.pinkAccent,
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
