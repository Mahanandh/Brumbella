import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../screens/custom_assets_screen.dart';

class AssetRegistryHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const AssetRegistryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Asset Registry',
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class QrGenerationPreview extends StatelessWidget {
  final String? generatedQRData;
  final String? generatedSerialNumber;

  const QrGenerationPreview({
    super.key,
    this.generatedQRData,
    this.generatedSerialNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 130,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: generatedQRData == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code, color: Colors.grey.shade400, size: 40),
                const SizedBox(height: 8),
                Text(
                  'Pending Generation...',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: QrImageView(
                    data: generatedQRData!,
                    size: 80.0,
                    foregroundColor: const Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  generatedSerialNumber!,
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
    );
  }
}

class ProvisionTagAction extends StatelessWidget {
  final VoidCallback onPressed;

  const ProvisionTagAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF16A34A),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: const Text(
        'Provision Asset Tag',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AssetDigitizationForm extends StatelessWidget {
  final TextEditingController nameController;
  final VoidCallback onGenerateTap;
  final String? generatedQRData;
  final String? generatedSerialNumber;

  const AssetDigitizationForm({
    super.key,
    required this.nameController,
    required this.onGenerateTap,
    this.generatedQRData,
    this.generatedSerialNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register Custom Asset',
                    style: TextStyle(
                      color: Color(0xFF16A34A),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter asset description...',
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ProvisionTagAction(onPressed: onGenerateTap),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            QrGenerationPreview(
              generatedQRData: generatedQRData,
              generatedSerialNumber: generatedSerialNumber,
            ),
          ],
        ),
      ),
    );
  }
}

class AssetSearchInput extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onChanged;
  final VoidCallback onScanPressed;

  const AssetSearchInput({
    super.key,
    required this.searchController,
    required this.onChanged,
    required this.onScanPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (_) => onChanged(),
            decoration: InputDecoration(
              hintText: 'Search by Serial ID...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF16A34A)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 52,
          width: 52,
          child: ElevatedButton(
            onPressed: onScanPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF16A34A),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Icon(Icons.qr_code_scanner, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class RegistryFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const RegistryFilterChip({
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
        selectedColor: const Color(0xFF16A34A).withOpacity(0.1),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF16A34A) : const Color(0xFF64748B),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color:
                isSelected ? const Color(0xFF16A34A) : const Color(0xFFE2E8F0),
          ),
        ),
      ),
    );
  }
}

class RegistryFilterGroup extends StatelessWidget {
  final List<String> options;
  final String selectedFilter;
  final ValueChanged<String> onSelected;

  const RegistryFilterGroup({
    super.key,
    required this.options,
    required this.selectedFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((filter) {
          return RegistryFilterChip(
            label: filter,
            isSelected: selectedFilter == filter,
            onSelected: (selected) {
              if (selected) {
                onSelected(filter);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}

class RegistrySectionHeading extends StatelessWidget {
  final String title;

  const RegistrySectionHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }
}

class CustomAssetSummaryTile extends StatelessWidget {
  final DigitizedAsset asset;
  final VoidCallback onTap;

  const CustomAssetSummaryTile({
    super.key,
    required this.asset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.inventory_2, color: Colors.blueGrey),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${asset.serialNumber} • ${asset.type}',
                      style:
                          TextStyle(color: Colors.green.shade700, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
