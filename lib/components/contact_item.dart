import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:phonebook/components/contact_image.dart';
import 'package:phonebook/entities/ph_contact.dart';


class ContactItem extends StatelessWidget {

  final PhContact contact;
  final Function callback;

  const ContactItem({required this.contact, required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    //logDebug(contact);
    return ListTile(
      leading: ContactImage(contact: contact,),
      title: Text(contact.displayName, overflow: TextOverflow.ellipsis,),
      trailing: contact.getFirstPhone() != null
          ? Text(contact.getFirstPhone()!.value)
          : contact.getFirstEmail() != null ? Text(contact.getFirstEmail()!.value) : const Text('-'),
      dense: true,
      onTap: () {
        callback(contact: contact);
      },
    );
  }
}