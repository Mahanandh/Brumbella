import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppliancesScreen extends StatelessWidget {
  const HomeAppliancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
        title: Text(
          'Home Appliances',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0).copyWith(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Registered Assets
            Text(
              'YOUR APPLIANCES',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 12),
            _buildAssetCard(
              title: 'RO Water Purifier',
              subtitle: 'Model: PureFlow 9L',
              status: 'EXPIRING',
              statusBgColor: const Color(0xFFFFF7ED),
              statusTextColor: const Color(0xFFC2410C),
            ),
            _buildAssetCard(
              title: 'Smart Washing Machine',
              subtitle: 'Model: AquaWave 8kg',
              status: 'ACTIVE',
              statusBgColor: const Color(0xFFECFDF5),
              statusTextColor: const Color(0xFF047857),
            ),
            const SizedBox(height: 32),

            // Section 2: Compatible Spare Parts
            Text(
              'QUICK SPARES & CONSUMABLES',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildSparePartCard(
                    title: 'PureFlow Carbon Filter Set',
                    price: '₹850',
                  ),
                  _buildSparePartCard(
                    title: 'AquaWave Inlet Hose 2m',
                    price: '₹450',
                  ),
                  _buildSparePartCard(
                    title: 'RO Membrane Replacement',
                    price: '₹1,200',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Section 3: Local Shops
            Text(
              'LOCAL SERVICE & PARTS DIRECTORY',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 12),
            _buildShopCard(
              title: 'Perambur Electronics & Spares',
              subtitle: 'Authorized parts • 1.2 km away',
            ),
            _buildShopCard(
              title: 'Chennai Appliance Care - Perambur',
              subtitle: 'Third-party repair & service • 2.5 km away',
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
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

  Widget _buildSparePartCard({
    required String title,
    required String price,
  }) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(Icons.build_circle_outlined, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF059669),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'Buy',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShopCard({
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: const Color(0xFF0F172A),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF64748B),
          ),
        ),
        trailing: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFECFDF5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.phone, color: Color(0xFF059669), size: 20),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
