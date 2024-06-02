import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:phonebook/entities/pb_contact.dart';

class DetailedContactRow extends StatelessWidget {

  const DetailedContactRow({super.key, required this.contact, required this.directContact, required this.tap});

  final PhContact contact;
  final PhDirectContact directContact;
  final Function tap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(directContact.type == PhDirectContactType.phone ? Icons.phone
                  : (directContact.type == PhDirectContactType.email ? Icons.email : Icons.link)
              ),
            )
        ),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                  directContact.label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, color: Colors.black, decoration: TextDecoration.none,)
              ),
            )
        ),
        Expanded(
            flex: 7,
            child: TextButton(
              style: const ButtonStyle(
                alignment: Alignment.centerLeft
              ),
              onPressed: () {},
              child: Text(
                  directContact.value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, color: Colors.black, decoration: TextDecoration.none,)
              ),
            ),
        ),
        TextButton(
          onPressed: () {  },
          style: const ButtonStyle(
              alignment: Alignment.centerRight
          ),
          child: const Icon(Icons.edit, size: 16,),
        ),
      ],
    );
  }
}