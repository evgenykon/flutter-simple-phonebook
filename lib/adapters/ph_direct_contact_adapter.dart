
import 'package:hive/hive.dart';
import 'package:phonebook/entities/ph_direct_contact.dart';

import '../enums/ph_enum_direct_contact_type.dart';

class PhDirectContactAdapter extends TypeAdapter<PhDirectContact> {
  @override
  PhDirectContact read(BinaryReader reader) {
    return PhDirectContact(
      type: reader.read() as PhDirectContactType,
      value: reader.read() as String,
      label: reader.read() as String
    );
  }

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, PhDirectContact obj) {
    writer
      ..write(obj.type)
      ..write(obj.value)
      ..write(obj.label);
  }

}