import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:phonebook/entities/ph_direct_contact.dart';

import '../entities/ph_contact.dart';

class PhContactAdapter extends TypeAdapter<PhContact> {

  @override
  PhContact read(BinaryReader reader) {
    String phoneBookId = reader.read() as String;
    String? firstName = reader.read() as String?;
    String? middleName = reader.read() as String?;
    String? lastName = reader.read() as String?;
    String displayName = reader.read() as String;
    DateTime? birthDate = reader.read() as DateTime?;
    var tmpContacts = reader.read() as List<dynamic>;
    List<PhDirectContact> directContacts = tmpContacts.cast<PhDirectContact>();
    Uint8List? photo = reader.read() as Uint8List?;
    var tmpTags = reader.read() as List<dynamic>;
    List<String> tags = tmpTags.cast<String>();
    String notes = reader.read() as String? ?? '';

    return PhContact(
      phoneBookId: phoneBookId,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      displayName: displayName,
      birthDate: birthDate,
      directContacts: directContacts,
      photo: photo,
      tags: tags,
      notes: notes
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, PhContact obj) {
    writer
      ..write(obj.phoneBookId)
      ..write(obj.firstName)
      ..write(obj.middleName)
      ..write(obj.lastName)
      ..write(obj.displayName)
      ..write(obj.birthDate)
      ..write(obj.directContacts)
      ..write(obj.photo)
      ..write(obj.tags);
  }

}