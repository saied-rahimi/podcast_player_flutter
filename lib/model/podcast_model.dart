import 'package:equatable/equatable.dart';

import 'episode_model.dart';

abstract class BaseModel extends Equatable {
  const BaseModel({this.id, required this.title});

  final int? id;
  final String title;
}

class PodcastModel extends BaseModel {
  const PodcastModel({super.id, required super.title, this.episodsList = const [], this.preventDelete = false});

  final List<EpisodeModel> episodsList;
  final bool preventDelete;

  factory PodcastModel.fromJson(Map<String, dynamic> json, bool preventDelete) {
    return PodcastModel(
      id: json['id'] as int,
      title: json['title'] as String,
      episodsList: (json['episodsList'] as List<dynamic>).map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>)).toList(),
      preventDelete: preventDelete,
    );
  }

  PodcastModel copyWith({int? id, String? title, List<EpisodeModel>? episodsList, bool? preventDelete}) {
    return PodcastModel(
      id: id ?? this.id,
      title: title ?? this.title,
      episodsList: episodsList ?? this.episodsList,
      preventDelete: preventDelete ?? this.preventDelete,
    );
  }

  @override
  List<Object?> get props => [id, title, episodsList, preventDelete];
}
