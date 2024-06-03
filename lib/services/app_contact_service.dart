import 'package:flutter_contacts/contact.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import 'package:phonebook/entities/ph_contact.dart';

import '../entities/ph_direct_contact.dart';
import '../enums/ph_enum_direct_contact_type.dart';

class AppContactService {

  static Future<List<PhContact>> mergeContacts(List<Contact> phoneContacts) async {

    Map<String, PhContact> mergedList = {};

    var contactsBox = await Hive.openBox('ph_contacts');
    List<String> mapIndex = await contactsBox.get('index', defaultValue: <String>[]);
    logDebug(mapIndex);

    List<String> updatedMapIndex = <String>[];
    for (var idIndex in mapIndex) {
      var fetchedContact = await contactsBox.get('$idIndex', defaultValue: null);
      if (fetchedContact == null) {
        logDebug('skip lost contact $idIndex');
        continue;
      }
      updatedMapIndex.add(idIndex);
      mergedList['$idIndex'] = fetchedContact;
      logDebug('load contact $idIndex');
    }

    List<String> phoneIndex = [];
    for (var contact in phoneContacts) {
      String phoneContactId = contact.id;
      phoneIndex.add('id:$phoneContactId');

      if (!mergedList.containsKey('id:$phoneContactId')) {
        List<PhDirectContact> directContacts = [];
        for (var item in contact.phones) {
          directContacts.add(PhDirectContact(type: PhDirectContactType.phone,
              value: item.number,
              label: item.label.name));
        }
        for (var item in contact.emails) {
          directContacts.add(PhDirectContact(type: PhDirectContactType.email,
              value: item.address,
              label: item.label.name));
        }

        var image = (contact.thumbnailFetched && contact.thumbnail != null)
            ? contact.thumbnail!
            : (contact.photoFetched && contact.photo != null)
            ? contact.photo! : null;

        mergedList['id:$phoneContactId'] = PhContact(
          phoneBookId: 'id:$phoneContactId',
          firstName: contact.name.first,
          middleName: contact.name.middle,
          lastName: contact.name.last,
          displayName: contact.displayName,
          birthDate: null,
          directContacts: directContacts,
          photo: image,
          tags: [],
          notes: ''
        );

        await contactsBox.put('id:$phoneContactId', mergedList['id:$phoneContactId']);

        logDebug('add contact to store: id:$phoneContactId');
        logDebug(mergedList['id:$phoneContactId']);

      } else {
        logDebug('find contact in store id:$phoneContactId');
      }

      //contacts.close();
    }

    for (var idIndex in updatedMapIndex) {
      if (!phoneIndex.contains(idIndex)) {
        mergedList.remove('$idIndex');
        await contactsBox.delete('$idIndex');
        logDebug('remove not-finded-in-phone contact from store $idIndex');
      }
    }

    updatedMapIndex.clear();
    for (var item in mergedList.values) {
      String phoneContactId = item.phoneBookId;
      updatedMapIndex.add('id:$phoneContactId');
    }

    await contactsBox.put('index', updatedMapIndex);
    logDebug('updatedMapIndex stored');
    logDebug(updatedMapIndex);

    return mergedList.values.toList();

  }

}