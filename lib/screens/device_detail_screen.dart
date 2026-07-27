import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_card.dart';
import 'manual_registration_screen.dart';

class DeviceDetailScreen extends StatelessWidget {
  final String categoryName;
  final CategoryDetailData? categoryData;

  const DeviceDetailScreen(
      {super.key, required this.categoryName, this.categoryData});

  String _getMockAssetTitle() {
    switch (categoryName) {
      case 'RO Water Purifiers':
        return 'Smart RO Water Purifier';
      case 'Washing Machines':
        return 'Smart Washing Machine';
      case 'Refrigerators':
        return 'Double Door Smart Fridge';
      case 'Dishwashers':
        return 'Built-in Dishwasher 14 Place';
      case 'Microwave Ovens':
        return 'Convection Microwave 28L';
      default:
        return 'Smart Appliance';
    }
  }

  String _getMockAssetModel() {
    switch (categoryName) {
      case 'RO Water Purifiers':
        return 'Model: PureFlow 9L';
      case 'Washing Machines':
        return 'Model: AquaWave 8kg';
      case 'Refrigerators':
        return 'Model: FrostFree 400L';
      case 'Dishwashers':
        return 'Model: CleanPro X';
      case 'Microwave Ovens':
        return 'Model: HeatMaster Pro';
      default:
        return 'Model: GenX 1.0';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasAssets = false; // Mock empty state toggle
    final data = categoryData ?? getMockDataForCategory(categoryName);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Slate 100
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
        title: Text(
          categoryName,
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
                  builder: (context) => ManualRegistrationScreen(
                    prefilledCategory: categoryName,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)
            .copyWith(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Registered Device
            Text(
              'YOUR ASSET',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 12),
            if (hasAssets)
              _buildAssetCard(
                title: _getMockAssetTitle(),
                subtitle: _getMockAssetModel(),
                status: 'ACTIVE',
                statusBgColor: const Color(0xFFECFDF5),
                statusTextColor: const Color(0xFF047857),
              )
            else
              PremiumCard(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16A34A).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.inventory_2_outlined,
                          size: 36, color: Color(0xFF16A34A)),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No assets registered in this category yet.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(color: const Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManualRegistrationScreen(
                              prefilledCategory: categoryName,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Register New Device"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF059669),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),

            // Section 2: Compatible Spare Parts
            Text(
              'COMPATIBLE SPARE PARTS',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 140, // Height bound required because Column has a Spacer
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data.spareParts
                      .map((part) => Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: PremiumCard(
                              width: 160,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF1F5F9),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: const Icon(
                                        Icons.build_circle_outlined,
                                        color: Color(0xFF94A3B8)),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(part.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                      maxLines: 2),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('₹${part.price}',
                                          style: const TextStyle(
                                              color: Color(0xFF16A34A),
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1E293B),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: const Text('Buy',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Section 3: Local Shops
            Text(
              'AUTHORIZED SERVICE & REPAIR',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: data.serviceCenters
                  .map((center) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: PremiumCard(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(center.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    const SizedBox(height: 4),
                                    Text(
                                        '${center.description} • ${center.distance}',
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF16A34A).withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.phone,
                                    color: Color(0xFF16A34A), size: 20),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetCard({
    required String title,
    required String subtitle,
    required String status,
    required Color statusBgColor,
    required Color statusTextColor,
  }) {
    return PremiumCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(8.0),
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
        ],
      ),
    );
  }
}

class SparePart {
  final String name;
  final int price;
  SparePart({required this.name, required this.price});
}

class ServiceCenter {
  final String name;
  final String description;
  final String distance;
  ServiceCenter(
      {required this.name, required this.description, required this.distance});
}

class CategoryDetailData {
  final String categoryName;
  final List<SparePart> spareParts;
  final List<ServiceCenter> serviceCenters;

  CategoryDetailData({
    required this.categoryName,
    required this.spareParts,
    required this.serviceCenters,
  });
}

CategoryDetailData getMockDataForCategory(String categoryName) {
  // Normalize the string to avoid case/spacing mismatches
  final name = categoryName.trim().toLowerCase();

  if (name.contains('television') ||
      name.contains('tv') ||
      name.contains('electronics')) {
    return CategoryDetailData(
      categoryName: categoryName,
      spareParts: [
        SparePart(name: 'Replacement Smart Remote', price: 899),
        SparePart(name: 'AC Power Cable', price: 350),
        SparePart(name: 'Heavy Duty Wall Mount', price: 1500),
      ],
      serviceCenters: [
        ServiceCenter(
            name: 'City Center Electronics',
            description: 'Authorized TV Repair',
            distance: '1.2 km away'),
        ServiceCenter(
            name: 'Screen Savers Hub',
            description: 'Display & Panel Experts',
            distance: '4.5 km away'),
      ],
    );
  } else if (name.contains('washing')) {
    return CategoryDetailData(
      categoryName: categoryName,
      spareParts: [
        SparePart(name: 'Inlet Hose', price: 450),
        SparePart(name: 'Drain Motor', price: 1200),
      ],
      serviceCenters: [
        ServiceCenter(
            name: 'Appliance Pro Care',
            description: 'Authorized Parts',
            distance: '3.2 km away'),
      ],
    );
  } else {
    // Default Fallback (RO Purifiers, etc.)
    return CategoryDetailData(
      categoryName: categoryName,
      spareParts: [
        SparePart(name: 'OEM Replacement Filter', price: 850),
        SparePart(name: 'Main Control Board', price: 2200),
      ],
      serviceCenters: [
        ServiceCenter(
            name: 'Metro Appliance Service',
            description: 'Authorized parts',
            distance: '2.5 km away'),
      ],
    );
  }
}
