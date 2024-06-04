import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detailed_contact_label.dart';

class DetailedContactNotesTab extends StatelessWidget {
  const DetailedContactNotesTab({super.key, required this.notes});

  final String notes;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text('Notes', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
      const Expanded(child: TextField(maxLines: null, decoration: InputDecoration.collapsed(hintText: "Enter your notes"),)),
    ],);
  }
}