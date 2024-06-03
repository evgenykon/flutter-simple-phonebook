import 'package:hive_flutter/hive_flutter.dart';

class EnumClassAdapter<T extends Enum> extends TypeAdapter<T> {
  EnumClassAdapter(this.typeId, this.values);

  @override
  final int typeId;

  final List<T> values;

  @override
  T read(BinaryReader reader) {
    final enumString = reader.read() as String;
    return values.firstWhere((e) => e.name == enumString);
  }

  @override
  void write(BinaryWriter writer, T obj) {
    writer.write(obj.name);
  }
}
