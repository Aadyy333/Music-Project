// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class songListModelAdapter extends TypeAdapter<songListModel> {
  @override
  final int typeId = 0;

  @override
  songListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return songListModel(
      displayName: fields[0] as String,
      artist: fields[1] as String,
      uri: fields[2] as String,
      title: fields[3] as String,
      songId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, songListModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.songId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is songListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
