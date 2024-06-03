import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../entities/ph_contact.dart';

class ContactImage extends StatelessWidget {

  final PhContact contact;
  final double baseSize;
  const ContactImage({required this.contact, this.baseSize = 30, super.key});

  @override
  Widget build(BuildContext context) {

    // var image = (contact.thumbnailFetched && contact.thumbnail != null)
    //     ? MemoryImage(contact.thumbnail!)
    //     : (contact.photoFetched && contact.photo != null)
    //     ? MemoryImage(contact.photo!) : null;

    var image = contact.photo != null ? MemoryImage(contact.photo! as Uint8List) : null;

    var textAvatar = Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: baseSize * 0.33),
      child: SizedBox(
        width: baseSize * 0.33,
        child: Text(
          contact.displayName.characters.first,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: baseSize * 0.57, color: Colors.black),
        ),
      ),
    );

    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: baseSize * 0.55,
      child: image != null
          ? CircleAvatar(
              backgroundColor: Colors.amber,
              radius: baseSize * 0.5,
              backgroundImage: image,
            )
          : CircleAvatar(
              backgroundColor: Colors.amber,
              radius: baseSize * 0.5,
              child: textAvatar,
            )
    );
  }
}