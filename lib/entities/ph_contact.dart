import 'dart:typed_data';
import 'package:hive/hive.dart';
import '../enums/ph_enum_direct_contact_type.dart';
import 'ph_direct_contact.dart';

@HiveType(typeId: 1)
class PhContact extends HiveObject {

  @HiveField(0)
  final String phoneBookId;

  @HiveField(1)
  final String? firstName;

  @HiveField(2)
  final String? middleName;

  @HiveField(3)
  final String? lastName;

  @HiveField(4)
  final String displayName;

  @HiveField(5)
  final DateTime? birthDate;

  @HiveField(6)
  final Iterable<PhDirectContact> directContacts;

  @HiveField(7)
  final Uint8List? photo;

  @HiveField(8)
  final Iterable<String> tags;

  @HiveField(8)
  final String notes;


  PhContact({
    required this.phoneBookId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.displayName,
    required this.birthDate,
    required this.directContacts,
    required this.photo,
    required this.tags,
    required this.notes
  });

  PhDirectContact? getFirstPhone () {
    for (var item in directContacts) {
      if (item.type == PhDirectContactType.phone) {
        return item;
      }
    }

    return null;
  }

  PhDirectContact? getFirstEmail () {
    for (var item in directContacts) {
      if (item.type == PhDirectContactType.email) {
        return item;
      }
    }

    return null;
  }
}
