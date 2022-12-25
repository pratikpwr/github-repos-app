part of 'user_repos_bloc.dart';

abstract class UserReposEvent extends Equatable {
  const UserReposEvent();
}

class GetUserRepos extends UserReposEvent {
  final String userName;

  const GetUserRepos(this.userName);

  @override
  List<Object> get props => [userName];
}
