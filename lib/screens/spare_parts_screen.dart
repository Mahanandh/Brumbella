import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_card.dart';

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
    CompatiblePart(partName: 'Dishwasher Salt / Liquid', compatibleModel: 'IFB Neptune VX', price: 450),
    CompatiblePart(partName: 'Smart AC Remote', compatibleModel: 'LG Dual Inverter', price: 899),
  ];

  final List<String> categories = ["All", "Filters & Liquids", "Cables", "Motors", "Mounts"];
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Spare Parts',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search
                  PremiumCard(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search parts or scan device barcode for exact match...",
                        hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                        suffixIcon: const Icon(Icons.qr_code_scanner, color: Color(0xFF16A34A)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Smart Replenishment
                  const Text(
                    'ESSENTIALS & REFILLS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  PremiumCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.water_drop, color: Color(0xFF94A3B8), size: 32),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                essential.consumableName,
                                style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15, color: const Color(0xFF0F172A)),
                              ),
                              Text(
                                essential.deviceName,
                                style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF64748B)),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.warning_amber_rounded, size: 14, color: Color(0xFFF59E0B)),
                                  const SizedBox(width: 4),
                                  Text(
                                    essential.status,
                                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFFF59E0B)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₹${essential.price}',
                              style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16, color: const Color(0xFF16A34A)),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF16A34A),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(80, 32),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('Order Now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Compatible With Your Assets
                  const Text(
                    'COMPATIBLE WITH YOUR ASSETS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: compatibleParts.map((part) => Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: PremiumCard(
                            width: 160,
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF94A3B8)),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  part.partName,
                                  style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: const Color(0xFF0F172A)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Fits: ${part.compatibleModel}',
                                  style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF64748B)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₹${part.price}',
                                      style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1E293B),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: const Text('Buy', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Categories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: selectedCategory == cat,
                          onSelected: (selected) {
                            if (selected) setState(() => selectedCategory = cat);
                          },
                          backgroundColor: Colors.white,
                          selectedColor: const Color(0xFF16A34A),
                          labelStyle: TextStyle(
                            color: selectedCategory == cat ? Colors.white : const Color(0xFF64748B),
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                          showCheckmark: false,
                        ),
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Browse All Parts
                  const Text(
                    'BROWSE ALL PARTS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 4, // Mock count
                    itemBuilder: (context, index) {
                      return PremiumCard(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.image_outlined, color: Color(0xFF94A3B8), size: 32),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Generic Spare Part ${index + 1}',
                              style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: const Color(0xFF0F172A)),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹${(index + 1) * 250}',
                                  style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF16A34A),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
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
