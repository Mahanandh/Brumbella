import 'package:flutter/material.dart';

class PremiumListCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color themeColor;

  const PremiumListCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.themeColor = const Color(0xFF16A34A), // Default brand green
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Soft Tinted Icon Container
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: themeColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Bold, Premium Typography
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B), // Slate 800
                    ),
                  ),
                ),
                // Sleek Trailing Chevron
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFFCBD5E1), // Slate 300
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
