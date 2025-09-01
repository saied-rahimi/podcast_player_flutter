import 'episode_model.dart';

abstract class BaseModel {
  const BaseModel({required this.id, required this.title});

  final int id;
  final String title;

  Map<String, dynamic> toMap();
}

class PodcastModel extends BaseModel {
  const PodcastModel({required super.id, required super.title, required this.episodsList});

  final List<EpisodeModel> episodsList;

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'episodsList': episodsList.map((e) => e.toMap()).toList()};
  }

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      id: json['id'] as int,
      title: json['title'] as String,
      episodsList: (json['episodsList'] as List<dynamic>).map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  PodcastModel copyWith({int? id, String? title, List<EpisodeModel>? episodsList}) {
    return PodcastModel(id: id ?? this.id, title: title ?? this.title, episodsList: episodsList ?? this.episodsList);
  }
}
