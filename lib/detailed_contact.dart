
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:phonebook/components/contact_image.dart';
import 'package:phonebook/components/detailed_contact_label.dart';
import 'package:phonebook/components/detailed_contact_labels_tab.dart';
import 'package:phonebook/components/detailed_contact_notes_tab.dart';
import 'package:phonebook/components/detailed_contact_row.dart';
import 'package:phonebook/entities/ph_contact.dart';
import 'package:phonebook/enums/ph_enum_direct_contact_type.dart';

class DetailedContact extends StatefulWidget {

  const DetailedContact({super.key, required this.contact});

  final PhContact contact;

  @override
  State<DetailedContact> createState() => _DetailedContactState();

}

class _DetailedContactState extends State<DetailedContact> with SingleTickerProviderStateMixin {

  late PhContact contact;
  int tabIndex = 0;
  late TabController _bottomTabController;

  @override
  void initState() {
    super.initState();
    _bottomTabController = TabController(length: 5, vsync: this);
    _bottomTabController.index = tabIndex;
  }

  @override
  void dispose() {
    _bottomTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    contact = widget.contact;
    var hasPhone = false;

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
        if (element.type == PhDirectContactType.phone) {
          hasPhone = true;
        }
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

    List<BottomNavigationBarItem> bottomButtons = [];
    List<Widget> bottomTabViews = [];
    bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black,), label: 'Profile'));
    bottomTabViews.add(const SizedBox.expand());
    if (hasPhone) {
      bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.call, color: Colors.black,), label: 'Call'));
      bottomTabViews.add(const SizedBox.expand());
    }
    bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.label, color: Colors.black,), label: 'Labels'));
    bottomTabViews.add(DetailedContactLabelsTab(labels: contact.tags,));
    bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.notes, color: Colors.black,), label: 'Notes'));
    bottomTabViews.add(DetailedContactNotesTab(notes: contact.notes,));
    bottomButtons.add(const BottomNavigationBarItem(icon: Icon(Icons.person_remove, color: Colors.black,), label: 'Delete'));
    bottomTabViews.add(const SizedBox.expand());

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
                  children: [
                    // rows of contacts
                    Expanded(child: Column(children: columnChildren,)),
                    const Divider(),
                    // tab views
                    Expanded(child: TabBarView(
                      controller: _bottomTabController,
                      children: bottomTabViews,
                    ))
                  ],
                )
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
              _bottomTabController.index = index;
            });
          },
          items: bottomButtons,
          selectedLabelStyle: const TextStyle(color: Colors.black),
          selectedItemColor: Colors.black,
        ),
      );
  }
}