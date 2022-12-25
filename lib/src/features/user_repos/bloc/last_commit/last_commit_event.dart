part of 'last_commit_bloc.dart';

abstract class LastCommitEvent extends Equatable {
  const LastCommitEvent();
}

class GetLastCommit extends LastCommitEvent {
  final String repoName;

  const GetLastCommit(this.repoName);

  @override
  List<Object> get props => [repoName];
}
