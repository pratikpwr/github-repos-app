import 'package:equatable/equatable.dart';

class RepoUser extends Equatable {
  final String userName;
  final String url;
  final String imageUrl;

  const RepoUser({
    required this.userName,
    required this.url,
    required this.imageUrl,
  });

  factory RepoUser.fromJson(Map<String, dynamic> json) {
    return RepoUser(
      userName: json["login"],
      url: json["url"],
      imageUrl: json["avatar_url"],
    );
  }

  @override
  List<Object> get props => [
        userName,
        url,
        imageUrl,
      ];
}
