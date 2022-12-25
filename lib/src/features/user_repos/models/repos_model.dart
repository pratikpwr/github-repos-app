import 'package:equatable/equatable.dart';

import 'commit_model.dart';
import 'user_model.dart';

class Repos extends Equatable {
  final int id;
  final String title;
  final String? description;
  final RepoUser owner;
  final bool isPrivate;
  final String url;
  final String? language;

  final Commit? lastCommit;

  const Repos({
    required this.id,
    required this.title,
    required this.owner,
    required this.description,
    required this.isPrivate,
    required this.url,
    required this.language,
    this.lastCommit,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        owner,
        description,
        isPrivate,
        url,
        language,
        lastCommit,
      ];

  factory Repos.fromJson(Map<String, dynamic> json) {
    return Repos(
      id: json["id"],
      title: json["name"],
      owner: RepoUser.fromJson(json["owner"]),
      description: json["description"],
      isPrivate: json["private"],
      language: json["language"],
      url: json["url"],
    );
  }
}
