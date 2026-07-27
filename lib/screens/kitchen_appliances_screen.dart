import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/premium_list_card.dart';
import 'device_detail_screen.dart';
import 'manual_registration_screen.dart';

class KitchenAppliancesScreen extends StatelessWidget {
  const KitchenAppliancesScreen({super.key});

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
          'Kitchen Appliances',
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
                    prefilledCategory: 'Kitchen Appliances',
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
          _buildSubCategoryCard(context, 'Dishwashers', Icons.wash_outlined),
          _buildSubCategoryCard(context, 'RO Water Purifiers and Dispensers',
              Icons.water_drop_outlined),
          _buildSubCategoryCard(
              context, 'Smart Refrigerators', Icons.kitchen_outlined),
          _buildSubCategoryCard(
              context, 'Microwave Ovens', Icons.microwave_outlined),
          _buildSubCategoryCard(context, 'Coffee Makers and Blenders',
              Icons.coffee_maker_outlined),
          _buildSubCategoryCard(context, 'Ventilator', Icons.air_outlined),
          _buildSubCategoryCard(context, 'Air Fryers', Icons.fastfood),
          _buildSubCategoryCard(context, 'Toasters', Icons.breakfast_dining),
          _buildSubCategoryCard(
              context, 'Electric Kettles', Icons.emoji_food_beverage),
          _buildSubCategoryCard(
              context, 'Food Processors & Choppers', Icons.restaurant),
          _buildSubCategoryCard(
              context, 'Rice Cookers & Steamers', Icons.rice_bowl),
          _buildSubCategoryCard(
              context, 'Hand & Stand Mixers', Icons.bakery_dining),
          _buildSubCategoryCard(context, 'Juicers', Icons.local_drink),
          _buildSubCategoryCard(
              context, 'Electric Grills', Icons.outdoor_grill),
          _buildSubCategoryCard(context, 'Kitchen Scales', Icons.scale),
        ],
      ),
    );
  }

  Widget _buildSubCategoryCard(
      BuildContext context, String title, IconData icon) {
    return PremiumListCard(
      title: title,
      icon: icon,
      themeColor: Colors.orange,
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
