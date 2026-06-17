import os

screens = {
    'home_appliances_screen.dart': '0xFF0072FF',
    'consumer_electronics_screen.dart': '0xFF8E2DE2',
    'it_networking_screen.dart': '0xFF11998E',
    'climate_control_screen.dart': '0xFF00B4DB',
    'smart_home_screen.dart': '0xFFF7971E',
    'medical_health_screen.dart': '0xFFFF416C',
    'power_energy_screen.dart': '0xFFFDC830',
    'vehicles_mobility_screen.dart': '0xFF00B09B',
    'furniture_fixtures_screen.dart': '0xFFBC4E9C',
    'building_screen.dart': '0xFF43C6AC'
}

for filename, color_hex in screens.items():
    filepath = os.path.join('lib', 'screens', filename)
    if not os.path.exists(filepath):
        print(f"Skipping {filename}")
        continue
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 1. Import PremiumListCard
    if 'premium_list_card.dart' not in content:
        content = content.replace("import 'device_detail_screen.dart';", "import '../widgets/premium_list_card.dart';\nimport 'device_detail_screen.dart';")
    
    # 2. Update Scaffold background
    content = content.replace('backgroundColor: const Color(0xFFF8FAFC),', 'backgroundColor: const Color(0xFFF8FAFC),')
    
    # 3. Update App bar
    content = content.replace('backgroundColor: Colors.white,', 'backgroundColor: Colors.transparent,')
    content = content.replace('elevation: 0,', 'elevation: 0,')
    # FontWeight is already w700
    
    # 4. Replace _buildSubCategoryCard implementation
    old_method_start = 'Widget _buildSubCategoryCard(BuildContext context, String title, IconData icon) {'
    new_method = f"""Widget _buildSubCategoryCard(BuildContext context, String title, IconData icon) {{
    return PremiumListCard(
      title: title,
      icon: icon,
      themeColor: const Color({color_hex}),
      onTap: () {{
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetailScreen(categoryName: title),
          ),
        );
      }},
    );
  }}"""
    
    # We need to replace the entire method body
    # Find start
    idx = content.find(old_method_start)
    if idx != -1:
        # Find the end of the method
        # It's at the end of the file, right before the last closing brace
        last_brace_idx = content.rfind('}')
        if last_brace_idx != -1:
            # We replace from idx to last_brace_idx
            content = content[:idx] + new_method + "\n}\n"
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"Refactored {filename}")
