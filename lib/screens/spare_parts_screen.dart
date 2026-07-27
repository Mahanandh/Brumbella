import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_card.dart';
import '../widgets/components_catalog/spare_parts_components.dart';

class AutoSuggestEssential {
  final String deviceName;
  final String consumableName;
  final String status;
  final int price;

  AutoSuggestEssential({
    required this.deviceName,
    required this.consumableName,
    required this.status,
    required this.price,
  });
}

class CompatiblePart {
  final String partName;
  final String compatibleModel;
  final int price;
  final bool inStock;

  CompatiblePart({
    required this.partName,
    required this.compatibleModel,
    required this.price,
    this.inStock = true,
  });
}

class SparePartsScreen extends StatefulWidget {
  const SparePartsScreen({super.key});

  @override
  State<SparePartsScreen> createState() => _SparePartsScreenState();
}

class _SparePartsScreenState extends State<SparePartsScreen> {
  final AutoSuggestEssential essential = AutoSuggestEssential(
    deviceName: 'RO Water Purifier',
    consumableName: 'OEM Carbon Filter',
    status: 'Refill Needed in 12 days',
    price: 850,
  );

  final List<CompatiblePart> compatibleParts = [
    CompatiblePart(
        partName: 'Dishwasher Salt / Liquid',
        compatibleModel: 'IFB Neptune VX',
        price: 450),
    CompatiblePart(
        partName: 'Smart AC Remote',
        compatibleModel: 'LG Dual Inverter',
        price: 899),
  ];

  final List<String> categories = [
    "All",
    "Filters & Liquids",
    "Cables",
    "Motors",
    "Mounts"
  ];
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CatalogPageHeader(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search
                  const PartSearchAndScanInput(),
                  const SizedBox(height: 32),

                  // Smart Replenishment
                  const CatalogSectionHeading(title: 'MAINTENANCE ESSENTIALS'),
                  const SizedBox(height: 12),
                  CriticalRefillSummaryRow(
                    itemName: essential.consumableName,
                    compatibilityText: essential.deviceName,
                    urgencyWarning: essential.status,
                    price: essential.price,
                    onOrderTap: () {},
                  ),
                  const SizedBox(height: 32),

                  // Compatible With Your Assets
                  const CatalogSectionHeading(
                      title: 'COMPATIBLE COMPONENTS'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: compatibleParts
                            .map((part) => CompatibleAccessoryTile(
                                  partName: part.partName,
                                  compatibleModel: part.compatibleModel,
                                  price: part.price,
                                  onBuyTap: () {},
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Categories
                  CatalogFilterChipGroup(
                    categories: categories,
                    selectedCategory: selectedCategory,
                    onCategorySelected: (cat) {
                      setState(() => selectedCategory = cat);
                    },
                  ),
                  const SizedBox(height: 32),

                  // Browse All Parts
                  const CatalogSectionHeading(title: 'COMPLETE INVENTORY'),
                  const SizedBox(height: 12),
                  CatalogInventoryGrid(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return StandardPartCatalogTile(
                        partName: 'Generic Spare Part ${index + 1}',
                        price: (index + 1) * 250,
                        imageUrl: '',
                        onAddTap: () {},
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
