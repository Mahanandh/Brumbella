import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'asset_details_screen.dart';
import '../components/custom_assets_components.dart';

class DigitizedAsset {
  final String name;
  final String serialNumber;
  final String type;

  DigitizedAsset({
    required this.name,
    required this.serialNumber,
    required this.type,
  });
}

class CustomAssetsScreen extends StatefulWidget {
  const CustomAssetsScreen({super.key});

  @override
  State<CustomAssetsScreen> createState() => _CustomAssetsScreenState();
}

class _CustomAssetsScreenState extends State<CustomAssetsScreen> {
  final List<DigitizedAsset> registeredAssets = [
    DigitizedAsset(
      name: 'LG Smart TV',
      serialNumber: 'SN-000001',
      type: 'Consumer Electronics',
    ),
    DigitizedAsset(
      name: 'Storage Cupboard A',
      serialNumber: 'SN-000002',
      type: 'Office & Industry',
    ),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String? _generatedQRData;
  String? _generatedSerialNumber;
  String _selectedFilter = 'All';

  final List<String> _filterOptions = [
    'All',
    'Consumer Electronics',
    'Office & Industry',
    'Custom Tag'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<DigitizedAsset> get filteredAssets {
    return registeredAssets.where((asset) {
      final matchesSearch = _searchController.text.isEmpty ||
          asset.serialNumber
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      final matchesFilter =
          _selectedFilter == 'All' || asset.type == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const AssetRegistryHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: The "Digitize Any Asset" Card
                AssetDigitizationForm(
                  nameController: _nameController,
                  generatedQRData: _generatedQRData,
                  generatedSerialNumber: _generatedSerialNumber,
                  onGenerateTap: () {
                    if (_nameController.text.isNotEmpty) {
                      final newSn =
                          "SN-${Random().nextInt(999999).toString().padLeft(6, '0')}";
                      setState(() {
                        _generatedSerialNumber = newSn;
                        _generatedQRData = newSn;
                        registeredAssets.insert(
                            0,
                            DigitizedAsset(
                              name: _nameController.text,
                              serialNumber: newSn,
                              type: 'Custom Tag',
                            ));
                        _nameController.clear();
                      });
                    }
                  },
                ),

                // Section 2: Search, Scan, and Filters
                const SizedBox(height: 24),
                // Search Row
                AssetSearchInput(
                  searchController: _searchController,
                  onChanged: () {
                    setState(() {});
                  },
                  onScanPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Camera scanner plugin to be implemented')),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Filters
                RegistryFilterGroup(
                  options: _filterOptions,
                  selectedFilter: _selectedFilter,
                  onSelected: (filter) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                ),

                const SizedBox(height: 24),
                // Section 3: The Asset List
                const RegistrySectionHeading(title: 'ACTIVE LIFECYCLE TRACKER'),
                const SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredAssets.length,
                  itemBuilder: (context, index) {
                    final asset = filteredAssets[index];
                    return CustomAssetSummaryTile(
                      asset: asset,
                      onTap: () {
                        print(
                            'SUCCESS: Tap registered for ${asset.name}. Attempting route...');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AssetDetailsScreen(asset: asset),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
