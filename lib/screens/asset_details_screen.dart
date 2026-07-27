import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'custom_assets_screen.dart'; // To get DigitizedAsset

class AssetDetailsScreen extends StatelessWidget {
  final DigitizedAsset asset;

  const AssetDetailsScreen({Key? key, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
        title: Text(
          asset.name,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The QR Card
                Container(
                  padding: const EdgeInsets.all(24.0),
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
                  child: Center(
                    child: QrImageView(
                      data: asset.serialNumber,
                      size: 200.0,
                      foregroundColor: const Color(0xFF334155),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Asset Info
                Text(
                  asset.serialNumber,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF334155),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16A34A).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        asset.type,
                        style: const TextStyle(
                          color: Color(0xFF16A34A),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16A34A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Active',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.print, color: Color(0xFF0F172A)),
                        label: const Text(
                          'Print Tag',
                          style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: const Text(
                          'Delete',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
