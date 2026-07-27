import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'asset_details_screen.dart';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: The "Digitize Any Asset" Card
                Container(
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
                        // Left Side (Input)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Digitize Any Asset',
                                style: TextStyle(
                                  color: Color(0xFF16A34A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter new device name...',
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF94A3B8)),
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
                                child: ElevatedButton(
                                  onPressed: () {
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
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF16A34A),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Generate Asset',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Right Side (Output)
                        Container(
                          height: 140,
                          width: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _generatedQRData == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.qr_code,
                                        color: Colors.grey.shade400, size: 40),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Awaiting Input...',
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 12),
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
                                        data: _generatedQRData!,
                                        size: 80.0,
                                        foregroundColor:
                                            const Color(0xFF334155),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _generatedSerialNumber!,
                                      style: const TextStyle(
                                        color: Color(0xFF475569),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Section 2: Search, Scan, and Filters
                const SizedBox(height: 24),
                // Search Row
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Serial Number...',
                          prefixIcon: const Icon(Icons.search,
                              color: Color(0xFF94A3B8)),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF16A34A)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Camera scanner plugin to be implemented')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16A34A),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Icon(Icons.qr_code_scanner,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filterOptions.map((filter) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedFilter = filter;
                              });
                            }
                          },
                          selectedColor:
                              const Color(0xFF16A34A).withOpacity(0.1),
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter
                                ? const Color(0xFF16A34A)
                                : const Color(0xFF64748B),
                            fontWeight: _selectedFilter == filter
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: _selectedFilter == filter
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 24),
                // Section 3: The Asset List
                const Text(
                  'YOUR DIGITIZED LIFECYCLE',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredAssets.length,
                  itemBuilder: (context, index) {
                    final asset = filteredAssets[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          // TELEMETRY: If this prints but doesn't route, it is a Web Cache issue.
                          print(
                              'SUCCESS: Tap registered for ${asset.name}. Attempting route...');

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AssetDetailsScreen(asset: asset),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.inventory_2,
                                    color: Colors.blueGrey),
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
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${asset.serialNumber} • ${asset.type}',
                                      style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right,
                                  color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
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
