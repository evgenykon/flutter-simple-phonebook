
import 'dart:typed_data';

enum PhDirectContactType {
  phone, email
}

class PhDirectContact {
  final PhDirectContactType type;
  final String value;
  final String label;

  PhDirectContact(this.type, this.value, this.label);
}

class PhContact {

  final String phoneBookId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String displayName;
  final DateTime? birthDate;
  final Iterable<PhDirectContact> directContacts;
  final Uint8List? photo;
  final Iterable<String> tags;

  PhContact(this.phoneBookId, this.firstName, this.middleName, this.lastName, this.displayName, this.birthDate, this.directContacts, this.photo, this.tags);

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
