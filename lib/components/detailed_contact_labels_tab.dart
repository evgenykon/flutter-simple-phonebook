import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detailed_contact_label.dart';

class DetailedContactLabelsTab extends StatelessWidget {
  const DetailedContactLabelsTab({super.key, required this.labels});

  final Iterable<String> labels;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in labels) {
      widgets.add(DetailedContactLabel(label: element));
    }
    return Column(children: [
      const Text('Labels', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
      Expanded(child: Wrap(
        alignment: WrapAlignment.start,
        children: widgets,
      )),
      Row(
        children: [
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add label')
          )
        ],
      )
    ],);
  }
}