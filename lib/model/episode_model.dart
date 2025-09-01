import 'package:podcast_player/model/podcast_model.dart';

class EpisodeModel extends BaseModel {
  const EpisodeModel({
    required super.id,
    required super.title,
    required this.isPlayed,
  });

  final bool isPlayed;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isPlayed': isPlayed,
    };
  }

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] as int,
      title: json['title'] as String,
      isPlayed: json['isPlayed'] as bool,
    );
  }

  EpisodeModel copyWith({
    int? id,
    String? title,
    bool? isPlayed,
  }) {
    return EpisodeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isPlayed: isPlayed ?? this.isPlayed,
    );
  }
}
