import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../premium_card.dart';

// Main Page Header
class CatalogPageHeader extends StatelessWidget implements PreferredSizeWidget {
  const CatalogPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Text(
        'Component Catalog',
        style: GoogleFonts.manrope(
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Search Bar
class PartSearchAndScanInput extends StatelessWidget {
  final TextEditingController? controller;

  const PartSearchAndScanInput({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Search components by name or scan barcode...",
          hintStyle:
              GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
          suffixIcon:
              const Icon(Icons.qr_code_scanner, color: Color(0xFF16A34A)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

// Section Titles
class CatalogSectionHeading extends StatelessWidget {
  final String title;

  const CatalogSectionHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: Color(0xFF64748B),
      ),
    );
  }
}

// Order Now Green Button
class PrimaryOrderAction extends StatelessWidget {
  final VoidCallback onPressed;

  const PrimaryOrderAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF16A34A),
        foregroundColor: Colors.white,
        minimumSize: const Size(80, 32),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text('Request Refill',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

// Essentials & Refills List Row
class CriticalRefillSummaryRow extends StatelessWidget {
  final String itemName;
  final String compatibilityText;
  final String urgencyWarning;
  final int price;
  final VoidCallback onOrderTap;

  const CriticalRefillSummaryRow({
    super.key,
    required this.itemName,
    required this.compatibilityText,
    required this.urgencyWarning,
    required this.price,
    required this.onOrderTap,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
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
            child: const Icon(Icons.water_drop,
                color: Color(0xFF94A3B8), size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: const Color(0xFF0F172A)),
                ),
                Text(
                  compatibilityText,
                  style: GoogleFonts.inter(
                      fontSize: 13, color: const Color(0xFF64748B)),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        size: 14, color: Color(0xFFF59E0B)),
                    const SizedBox(width: 4),
                    Text(
                      urgencyWarning,
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF59E0B)),
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
                '₹$price',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: const Color(0xFF16A34A)),
              ),
              const SizedBox(height: 8),
              PrimaryOrderAction(onPressed: onOrderTap),
            ],
          ),
        ],
      ),
    );
  }
}

// "Buy" Dark Button
class SecondaryPurchaseAction extends StatelessWidget {
  final VoidCallback? onTap;

  const SecondaryPurchaseAction({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text('Procure',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// Horizontal "Compatible With Your Assets" Cards
class CompatibleAccessoryTile extends StatelessWidget {
  final String partName;
  final String compatibleModel;
  final int price;
  final VoidCallback? onBuyTap;

  const CompatibleAccessoryTile({
    super.key,
    required this.partName,
    required this.compatibleModel,
    required this.price,
    this.onBuyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: const Icon(Icons.inventory_2_outlined,
                  color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 8),
            Text(
              partName,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: const Color(0xFF0F172A)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Fits: $compatibleModel',
              style: GoogleFonts.inter(
                  fontSize: 11, color: const Color(0xFF64748B)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹$price',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF16A34A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                SecondaryPurchaseAction(onTap: onBuyTap),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Category Filter Chip
class CatalogFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const CatalogFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: onSelected,
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF16A34A),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF64748B),
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.transparent),
        ),
        showCheckmark: false,
      ),
    );
  }
}

// Category Filter Chip Group
class CatalogFilterChipGroup extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CatalogFilterChipGroup({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map((cat) => CatalogFilterChip(
                  label: cat,
                  isSelected: selectedCategory == cat,
                  onSelected: (selected) {
                    if (selected) {
                      onCategorySelected(cat);
                    }
                  },
                ))
            .toList(),
      ),
    );
  }
}

// Generic Parts Grid Container
class CatalogInventoryGrid extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;

  const CatalogInventoryGrid({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

// The Green '+' Add Button
class QuickAddToCartTrigger extends StatelessWidget {
  final VoidCallback? onTap;

  const QuickAddToCartTrigger({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xFF16A34A),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 16),
      ),
    );
  }
}

// Individual Grid Items
class StandardPartCatalogTile extends StatelessWidget {
  final String partName;
  final int price;
  final String imageUrl;
  final VoidCallback onAddTap;

  const StandardPartCatalogTile({
    super.key,
    required this.partName,
    required this.price,
    required this.imageUrl, // Image is mocked in current build with an Icon placeholder, but parameterized for future
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
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
              // When an image is ready, Replace Icon with Image.network(imageUrl)
              child: const Icon(Icons.image_outlined,
                  color: Color(0xFF94A3B8), size: 32),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            partName,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: const Color(0xFF0F172A)),
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹$price',
                style: GoogleFonts.inter(
                    color: const Color(0xFF16A34A),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              QuickAddToCartTrigger(onTap: onAddTap),
            ],
          ),
        ],
      ),
    );
  }
}
