import 'package:flutter/material.dart';
import 'package:graphical_model_interface/theme.dart';

class MultiSelector extends StatefulWidget {
  final List<String> options;
  final List<String> initialSelected;
  final ValueChanged<List<String>>? onSelectionChanged;
  final bool compact;

  const MultiSelector({
    super.key,
    required this.options,
    required this.initialSelected,
    this.onSelectionChanged,
    this.compact = true,
  });

  @override
  State<MultiSelector> createState() => _MultiSelectorState();
}

class _MultiSelectorState extends State<MultiSelector> {
  late List<String> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = List<String>.from(widget.initialSelected);
  }

  void toggleOption(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(selectedOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20 + MediaQuery.of(context).size.width * 0.1,
          vertical: 10),
      child: Wrap(
        spacing: widget.compact ? 10 : 20,
        runSpacing: widget.compact ? 10 : 16,
        children: widget.options.map((option) {
          bool isSelected = selectedOptions.contains(option);
          return InkWell(
            onTap: () => toggleOption(option),
            child: Container(
              width: widget.compact ? 250 : 150,
              // height: widget.compact ? 35 : 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSelected ? Col.blue : Colors.grey.shade700,
                            width: 2),
                        color: isSelected ? Col.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Text(option),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
