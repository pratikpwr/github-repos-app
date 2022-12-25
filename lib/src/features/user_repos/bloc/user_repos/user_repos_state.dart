part of 'user_repos_bloc.dart';

abstract class UserReposState extends Equatable {
  const UserReposState();

  @override
  List<Object> get props => [];
}

class UserReposInitial extends UserReposState {}

class UserReposLoading extends UserReposState {}

class UserReposSuccess extends UserReposState {
  final List<Repos> projects;

  const UserReposSuccess(this.projects);

  @override
  List<Object> get props => [projects];
}

class UserReposFailure extends UserReposState {
  final FailureType type;

  const UserReposFailure(this.type);

  @override
  List<Object> get props => [type];
}
