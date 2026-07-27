import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManualRegistrationScreen extends StatefulWidget {
  final String? prefilledCategory;

  const ManualRegistrationScreen({super.key, this.prefilledCategory});

  @override
  State<ManualRegistrationScreen> createState() =>
      _ManualRegistrationScreenState();
}

class _ManualRegistrationScreenState extends State<ManualRegistrationScreen> {
  late TextEditingController _categoryController;
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categoryController =
        TextEditingController(text: widget.prefilledCategory ?? '');
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _dateController.dispose();
    super.dispose();
  }

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
          'Manual Registration',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField('Category', _categoryController,
                enabled: widget.prefilledCategory == null),
            const SizedBox(height: 16),
            _buildTextField('Brand', _brandController),
            const SizedBox(height: 16),
            _buildTextField('Model Number', _modelController),
            const SizedBox(height: 16),
            _buildTextField('Purchase Date', _dateController,
                hint: 'YYYY-MM-DD'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Mock save action
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Asset Registered Successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Save Asset',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool enabled = true, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: enabled ? Colors.white : const Color(0xFFF1F5F9),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF059669)),
            ),
          ),
        ),
      ],
    );
  }
}
