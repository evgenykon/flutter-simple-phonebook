
import 'dart:typed_data';

import 'package:flutter_contacts/contact.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import 'package:phonebook/entities/pb_contact.dart';

class AppContactService {

  static Future<List<PhContact>> mergeContacts(List<Contact> phoneContacts) async {

    Map<String, PhContact> mergedList = {};

    var contacts = await Hive.openBox('ph_contacts');
    List<String> mapIndex = await contacts.get('index', defaultValue: <String>[]);

    for (var index in mapIndex) {
      var fetchedContact = await contacts.get('id:$index', defaultValue: null);
      if (fetchedContact == null) {
        throw Exception('null value for contact $index');
      }
      mergedList['id:$index'] = fetchedContact;
    }

    List<String> phoneIndex = [];
    for (var contact in phoneContacts) {

      String contactId = contact.id;
      phoneIndex.add(contactId);

      if (!mergedList.containsKey('id:$contactId')) {

        List<PhDirectContact> directContacts = [];
        for (var item in contact.phones) {
          directContacts.add(PhDirectContact(PhDirectContactType.phone, item.number, item.label.name));
        }
        for (var item in contact.emails) {
          directContacts.add(PhDirectContact(PhDirectContactType.email, item.address, item.label.name));
        }

        var image = (contact.thumbnailFetched && contact.thumbnail != null)
            ? contact.thumbnail!
            : (contact.photoFetched && contact.photo != null)
            ? contact.photo! : null;

        mergedList['id:$contactId'] = PhContact(
          'id:$contactId',
          contact.name.first,
          contact.name.middle,
          contact.name.last,
          contact.displayName,
          null,
          directContacts,
          image,
          []
        );

        contacts.put('id:$contactId', mergedList['id:$contactId']);

        logDebug('add contact to store');
      }
    }

    for (var item in mapIndex) {
      if (!phoneIndex.contains(item)) {
        mergedList.remove('id:$item');
        contacts.delete('id:$item');
        logDebug('remove contact from store');
      }
    }

    mapIndex.clear();
    for (var item in mergedList.values) {
      mapIndex.add(item.phoneBookId);
    }
    contacts.put('index', mapIndex);
    logDebug('update index');

    return mergedList.values.toList();

  }

}