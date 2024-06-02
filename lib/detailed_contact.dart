
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/components/contact_image.dart';
import 'package:phonebook/components/detailed_contact_row.dart';
import 'package:phonebook/entities/pb_contact.dart';

class DetailedContact extends StatelessWidget {

  const DetailedContact({super.key, required this.contact});

  final PhContact contact;

  @override
  Widget build(BuildContext context) {

    var columnChildren = <Widget>[
      Text(
        contact.displayName,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
      ),
      Container(height: 20,),
      ContactImage(contact: contact, baseSize: 80,),
      Container(height: 20,),
    ];

    if (contact.directContacts.isNotEmpty) {
      for (var element in contact.directContacts) {
        columnChildren.add(
            DetailedContactRow(
              contact: contact,
              directContact: element,
              tap: () {},
            )
        );
      }
    }

    columnChildren.add(
      Row(
        children: [
          Padding(padding: const EdgeInsets.all(5), child: ElevatedButton(
            onPressed: () {  },
            child: Text('Add item'),
          ),),
          Padding(padding: const EdgeInsets.all(5), child: ElevatedButton(
            onPressed: () {  },
            child: Text('Set label'),
          ),),

        ],
      )

    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Phonebook'),
        ),
        body: DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 0.25,
          maxChildSize: 1,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: columnChildren,
                )
            );
          },
        )
      );
  }
}