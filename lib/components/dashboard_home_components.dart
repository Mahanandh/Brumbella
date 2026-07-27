import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. Top App Bar/Header
class ApplicationNavigationBar extends StatelessWidget {
  final String userName;
  const ApplicationNavigationBar({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 12),
                  Text.rich(
                    TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                      children: const [
                        TextSpan(
                            text: 'B',
                            style: TextStyle(color: Color(0xFF16A34A))),
                        TextSpan(
                            text: 'rum', style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'B',
                            style: TextStyle(color: Color(0xFF16A34A))),
                        TextSpan(
                            text: 'ella',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  text: 'Hello, ',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: userName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SystemNotificationIcon(),
        ],
      ),
    );
  }
}

// 2. Bell/Notification Icon Button
class SystemNotificationIcon extends StatelessWidget {
  const SystemNotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
          ),
          child: const Icon(
            Icons.notifications_none_outlined,
            color: Color(0xFF475569),
            size: 24,
          ),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF059669),
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                  BorderSide(color: Colors.white, width: 1.5)),
            ),
          ),
        ),
      ],
    );
  }
}

// 4. "Scan QR Code" Button
class QRCodeCaptureTrigger extends StatelessWidget {
  final VoidCallback onPressed;
  const QRCodeCaptureTrigger({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF0F172A)),
        label: Text(
          'Scan Asset Tag',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 52),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

// 5. Serial Number TextField
class DeviceSerialInput extends StatelessWidget {
  final TextEditingController? controller;
  const DeviceSerialInput({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
        ),
        child: TextField(
          controller: controller,
          style: GoogleFonts.inter(fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Enter Device Serial ID',
            hintStyle: TextStyle(color: Color(0xFF94A3B8)),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }
}

// 6. "Ingest Asset" Button
class RegisterNewAssetButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RegisterNewAssetButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        minimumSize: const Size(120, 52),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        'Register Asset',
        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
    );
  }
}

// 7. "Register manually" Text Link
class ManualOnboardingFallbackLink extends StatelessWidget {
  final VoidCallback onPressed;
  const ManualOnboardingFallbackLink({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          "No ID available? Add asset manually.",
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF059669),
          ),
        ),
      ),
    );
  }
}

// 3. Registration Card (Scan/Serial area)
class QuickAssetRegistrationForm extends StatelessWidget {
  final VoidCallback onScanPressed;
  final VoidCallback onIngestPressed;
  final VoidCallback onManualRegistrationPressed;
  final TextEditingController? serialController;

  const QuickAssetRegistrationForm({
    super.key,
    required this.onScanPressed,
    required this.onIngestPressed,
    required this.onManualRegistrationPressed,
    this.serialController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QRCodeCaptureTrigger(onPressed: onScanPressed),
        const SizedBox(height: 12),
        Row(
          children: [
            DeviceSerialInput(controller: serialController),
            const SizedBox(width: 12),
            RegisterNewAssetButton(onPressed: onIngestPressed),
          ],
        ),
        const SizedBox(height: 8),
        ManualOnboardingFallbackLink(onPressed: onManualRegistrationPressed),
      ],
    );
  }
}

// 8. Header widget
class DashboardSectionHeading extends StatelessWidget {
  final String title;
  const DashboardSectionHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        color: const Color(0xFF64748B),
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
      ),
    );
  }
}

// 12. "View all" Text Button
class ExpandPortfolioRoute extends StatelessWidget {
  final VoidCallback onTap;
  const ExpandPortfolioRoute({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Manage Portfolio',
        style: GoogleFonts.inter(
          color: const Color(0xFF16A34A),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

// 9. Grid Container for Categories
class AssetClassificationGrid extends StatelessWidget {
  final List<Widget> children;
  const AssetClassificationGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      childAspectRatio: 0.85,
      children: children,
    );
  }
}

// 10. Category Cards (formerly PremiumCategoryCard)
class AssetCategorySelector extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? imageAsset;
  final List<Color> gradientColors;
  final VoidCallback? onTap;

  const AssetCategorySelector({
    super.key,
    required this.title,
    required this.icon,
    this.imageAsset,
    required this.gradientColors,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.15),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageAsset != null
                ? Container(
                    width: 72.0,
                    height: 72.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF16A34A),
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Transform.scale(
                        scale: 1.15,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.matrix(<double>[
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ]),
                          child: Image.asset(
                            imageAsset!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 52.0,
                    width: 52.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradientColors,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: gradientColors.last.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155),
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 14. Status Pills
class AssetLifecycleStatusBadge extends StatelessWidget {
  final String status;
  const AssetLifecycleStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusBgColor;
    Color statusTextColor;

    if (status == 'ACTIVE') {
      statusBgColor = const Color(0xFFDCFCE7);
      statusTextColor = const Color(0xFF16A34A);
    } else if (status == 'EXPIRING') {
      statusBgColor = const Color(0xFFFFEDD5);
      statusTextColor = const Color(0xFFEA580C);
    } else {
      statusBgColor = const Color(0xFFFEE2E2);
      statusTextColor = const Color(0xFFDC2626);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusBgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(
          color: statusTextColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// 13. Individual Asset Rows
class TrackedAssetSummaryRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;

  const TrackedAssetSummaryRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Icon(icon, color: const Color(0xFF475569), size: 20),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            color: const Color(0xFF64748B),
            fontSize: 12,
          ),
        ),
        trailing: AssetLifecycleStatusBadge(status: status),
      ),
    );
  }
}

// 11. List Container for Recent Assets
class ActivePortfolioFeed extends StatelessWidget {
  final List<Widget> children;
  const ActivePortfolioFeed({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children,
    );
  }
}

// 15. Bottom Navigation Bar
class GlobalModuleSwitcher extends StatelessWidget {
  final int currentTab;
  final ValueChanged<int> onTabChanged;

  const GlobalModuleSwitcher({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });

  Widget _buildBottomTab(int index, IconData icon, String label) {
    final bool isActive = currentTab == index;
    final color = isActive ? const Color(0xFF059669) : const Color(0xFF64748B);

    return InkWell(
      onTap: () => onTabChanged(index),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomTab(0, Icons.home_outlined, 'Dashboard'),
          _buildBottomTab(1, Icons.inventory_2_outlined, 'Components'),
          const SizedBox(width: 48),
          _buildBottomTab(3, Icons.category_outlined, 'Custom Tags'),
          _buildBottomTab(4, Icons.settings_outlined, 'Settings'),
        ],
      ),
    );
  }
}

// 16. Floating Action Button (Center Scan)
class GlobalScanActionTrigger extends StatelessWidget {
  final VoidCallback onPressed;
  const GlobalScanActionTrigger({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF059669),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
          SizedBox(width: 4),
          Icon(Icons.keyboard_alt_outlined, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
