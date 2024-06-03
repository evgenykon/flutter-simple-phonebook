
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:phonebook/components/contact_image.dart';
import 'package:phonebook/components/detailed_contact_label.dart';
import 'package:phonebook/components/detailed_contact_row.dart';
import 'package:phonebook/entities/ph_contact.dart';

class DetailedContact extends StatefulWidget {

  const DetailedContact({super.key, required this.contact});

  final PhContact contact;

  @override
  State<DetailedContact> createState() => _DetailedContactState();

}

class _DetailedContactState extends State<DetailedContact> {

  late PhContact contact;
  int tabIndex = 1;
  bool hasPhone = false;

  @override
  Widget build(BuildContext context) {

    contact = widget.contact;

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
      const SizedBox(height: 20,)
    );
    columnChildren.add(
      Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add row')
          )
        ],
      )
    );

    if (contact.tags.isNotEmpty) {
      List<Widget> labels = [];
      for (var element in contact.tags) {
        labels.add(DetailedContactLabel(label: element));
      }
      columnChildren.add(
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.start,
            children: labels,
          )
        )
      );
    }

    List<BottomNavigationBarItem> bottomButtons = [];
    bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black,), label: 'Profile'));
    if (hasPhone) {
      bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.call, color: Colors.black,), label: 'Call'));
    }
    bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.label, color: Colors.black,), label: 'Set labels'));
    bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.notes, color: Colors.black,), label: 'Notes'));
    bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.person_remove, color: Colors.black,), label: 'Delete contact'));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Phonebook'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (int index) {},
          items: bottomButtons,
          selectedLabelStyle: const TextStyle(color: Colors.black),
          selectedItemColor: Colors.black,
        ),
      );
  }
}