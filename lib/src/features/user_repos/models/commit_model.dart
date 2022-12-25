import 'package:equatable/equatable.dart';

class Commit extends Equatable {
  final String message;
  final String sha;
  final String committer;
  final DateTime dateTime;

  const Commit({
    required this.message,
    required this.sha,
    required this.committer,
    required this.dateTime,
  });

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      message: json["commit"]["message"],
      sha: json["sha"],
      committer: json["commit"]["committer"]["name"],
      dateTime: DateTime.parse(json["commit"]["committer"]["date"]).toLocal(),
    );
  }

  @override
  List<Object> get props => [message, sha, committer];
}
