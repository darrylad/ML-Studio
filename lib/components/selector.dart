import 'package:flutter/material.dart';
import 'package:graphical_model_interface/theme.dart';

class Selector extends StatefulWidget {
  final List<String> selectors;
  final String defaultSelector;
  final ValueChanged<String>? onSelectionChanged;
  final bool wide;
  final bool compact;

  const Selector(
      {super.key,
      required this.selectors,
      required this.defaultSelector,
      this.onSelectionChanged,
      this.wide = false,
      this.compact = true});

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  late String selectedElement;

  @override
  void initState() {
    super.initState();
    selectedElement = widget.defaultSelector;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              (widget.wide ? 8 : 20 + MediaQuery.of(context).size.width * 0.1),
          vertical: 10),
      child: Wrap(
        spacing: widget.compact ? 10 : 32,
        alignment: WrapAlignment.center,
        runSpacing: widget.compact ? 10 : 16,
        children: widget.selectors.map((selectorElement) {
          bool isSelected = selectedElement == selectorElement;
          return InkWell(
            onTap: () {
              if (widget.onSelectionChanged != null) {
                widget.onSelectionChanged!(selectorElement);
              }

              setState(() {
                selectedElement = selectorElement;
              });
            },
            child: Container(
              width: widget.compact ? 250 : 150,
              height: widget.compact ? 35 : 50,
              decoration: BoxDecoration(
                color: isSelected ? Col.blue : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  selectorElement,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
