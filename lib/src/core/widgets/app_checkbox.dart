import 'package:flutter/material.dart';
import 'package:starter_riverpod/src/core/core.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox({
    super.key,
    required this.description,
    required this.onChanged,
  });

  final String description;
  final void Function(bool) onChanged;

  @override
  _AppCheckboxState createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool _isChecked = false; // Initial checkbox state

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: _isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue!;
            });
            widget.onChanged(_isChecked); // Callback function
          },
          activeColor: AppColors.primaryColor, // Customize checkbox color
        ),
        Text(
          widget.description,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
