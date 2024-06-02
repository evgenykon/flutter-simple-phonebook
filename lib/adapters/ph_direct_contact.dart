import 'package:hive/hive.dart';

enum PhDirectContactType {
  phone, email
}

@HiveType(typeId: 2)
class PhDirectContact {
  final PhDirectContactType type;
  final String value;
  final String label;

  PhDirectContact(this.type, this.value, this.label);
}