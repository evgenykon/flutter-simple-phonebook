import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedContactLabel extends StatelessWidget {
  const DetailedContactLabel({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.label_important_outline),
        label: Text(label),
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.amber),
            iconSize: WidgetStatePropertyAll<double>(16),
            textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14, color: Colors.black)),
            padding: WidgetStatePropertyAll(EdgeInsets.fromLTRB(10, 0, 10, 0)),
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10)))
            )
        ),
      ),
    );
  }
}