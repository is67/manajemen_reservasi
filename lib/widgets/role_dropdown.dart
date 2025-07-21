import 'package:flutter/material.dart';

class RoleDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const RoleDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: 'Role',
        prefixIcon: const Icon(Icons.admin_panel_settings_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: const [
        DropdownMenuItem(
          value: 'admin',
          child: Row(
            children: [
              Icon(Icons.admin_panel_settings, size: 16),
              SizedBox(width: 8),
              Text('Admin'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'staff',
          child: Row(
            children: [
              Icon(Icons.person, size: 16),
              SizedBox(width: 8),
              Text('Staff'),
            ],
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
