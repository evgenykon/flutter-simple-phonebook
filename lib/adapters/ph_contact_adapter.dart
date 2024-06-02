import 'package:hive/hive.dart';

import '../entities/ph_contact.dart';

class PhContactAdapter extends TypeAdapter<PhContact> {
  @override
  PhContact read(BinaryReader reader) {
    return PhContact(
      phoneBookId: reader.read().phoneBookId,
      firstName: reader.read().firstName,
      middleName: reader.read().middleName,
      lastName: reader.read().lastName,
      displayName: reader.read().displayName,
      birthDate: reader.read().birthDate,
      directContacts: reader.read().directContacts,
      photo: reader.read().photo,
      tags: reader.read().tags
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, PhContact obj) {
    writer.write(obj.phoneBookId);
    writer.write(obj.firstName);
    writer.write(obj.middleName);
    writer.write(obj.lastName);
    writer.write(obj.displayName);
    writer.write(obj.birthDate);
    writer.write(obj.directContacts);
    writer.write(obj.photo);
    writer.write(obj.tags);
  }

}