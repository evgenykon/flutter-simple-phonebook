import 'package:hive/hive.dart';

import '../enums/ph_enum_direct_contact_type.dart';

@HiveType(typeId: 2)
class PhDirectContact {
  final PhDirectContactType type;
  final String value;
  final String label;

  PhDirectContact({required this.type, required this.value, required this.label});
}