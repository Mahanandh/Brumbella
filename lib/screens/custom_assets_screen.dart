import 'package:flutter/material.dart';
import '../widgets/premium_card.dart';

class CustomAsset {
  final String name;
  final String type;
  final String detail1;
  final String detail2;
  final IconData icon;
  final Color themeColor;

  CustomAsset({
    required this.name,
    required this.type,
    required this.detail1,
    required this.detail2,
    required this.icon,
    required this.themeColor,
  });
}

class CustomAssetsScreen extends StatefulWidget {
  const CustomAssetsScreen({super.key});

  @override
  State<CustomAssetsScreen> createState() => _CustomAssetsScreenState();
}

class _CustomAssetsScreenState extends State<CustomAssetsScreen> {
  final List<CustomAsset> _assets = [
    CustomAsset(
      name: 'LG Smart TV',
      type: 'Consumer Electronics',
      detail1: 'Warranty Active',
      detail2: 'Expires in 8 months',
      icon: Icons.tv,
      themeColor: Colors.indigo,
    ),
    CustomAsset(
      name: 'Storage Cupboard A',
      type: 'Office & Industry',
      detail1: 'Custom Tag: 14 Files',
      detail2: 'Last audited: Today',
      icon: Icons.kitchen,
      themeColor: Colors.blue,
    ),
    CustomAsset(
      name: 'Leg Press Machine',
      type: 'Gym / Personal',
      detail1: 'Profile: 120kg, Pos 4',
      detail2: 'Last used: 2 days ago',
      icon: Icons.fitness_center,
      themeColor: Colors.purple,
    ),
    CustomAsset(
      name: 'ECG Monitor V2',
      type: 'Medical Device',
      detail1: 'Status: Operational',
      detail2: 'Next Calibration: Oct 12',
      icon: Icons.monitor_heart,
      themeColor: Colors.red,
    ),
  ];

  final List<String> _categories = [
    "All",
    "Consumer Electronics",
    "Office & Industry",
    "Medical Devices",
    "Custom Tags"
  ];
  
  String _selectedCategory = "All";
  bool _assetGenerated = false;

  @override
  Widget build(BuildContext context) {
    // Filter assets
    List<CustomAsset> filteredAssets = _selectedCategory == "All"
        ? _assets
        : _assets.where((a) {
            if (_selectedCategory == "Custom Tags") {
               return a.type != "Consumer Electronics" && 
                      a.type != "Office & Industry" && 
                      a.type != "Medical Device";
            }
            if (_selectedCategory == "Medical Devices" && a.type == "Medical Device") return true;
            return a.type == _selectedCategory;
          }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Custom Assets',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // The Universal Header
                  PremiumCard(
                    padding: const EdgeInsets.all(20),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Left Section: Input & Action
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Digitize Any Asset',
                                  style: TextStyle(
                                    color: Color(0xFF16A34A),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Scan a QR or Barcode to track electronics, medical devices, office equipment, or create a custom tag.',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 13,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter new device name...',
                                    hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF16A34A).withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _assetGenerated = true;
                                      });
                                    },
                                    icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                                    label: const Text(
                                      'Scan Asset ID',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF16A34A),
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Right Section: Dynamic Output Zone
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _assetGenerated
                                    ? [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: const Color(0xFFE2E8F0)),
                                          ),
                                          child: const Icon(
                                            Icons.qr_code_2,
                                            size: 72,
                                            color: Color(0xFF334155),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'SN: XXXX-1234',
                                          style: TextStyle(
                                            color: Color(0xFF475569),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ]
                                    : [
                                        Icon(
                                          Icons.qr_code_scanner,
                                          size: 48,
                                          color: Colors.grey.shade400,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Awaiting Input...',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Industry-Wide Category Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((category) {
                        final isSelected = category == _selectedCategory;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF16A34A)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF16A34A)
                                      : const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // The Custom Asset List Header
                  const Text(
                    'YOUR DIGITIZED LIFECYCLE',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                ]),
              ),
            ),
            
            // Asset Cards
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final asset = filteredAssets[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: PremiumCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: asset.themeColor.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(asset.icon, color: asset.themeColor),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    asset.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF334155),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  // Type badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: asset.themeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      asset.type,
                                      style: TextStyle(
                                        color: asset.themeColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    asset.detail1,
                                    style: const TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    asset.detail2,
                                    style: const TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF1F5F9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF64748B),
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: filteredAssets.length,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100.0)),
          ],
        ),
      ),
    );
  }
}
