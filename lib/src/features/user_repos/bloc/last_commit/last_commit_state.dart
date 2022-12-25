part of 'last_commit_bloc.dart';

abstract class LastCommitState extends Equatable {
  const LastCommitState();

  @override
  List<Object> get props => [];
}

class LastCommitInitial extends LastCommitState {}

class LastCommitLoading extends LastCommitState {}

class LastCommitSuccess extends LastCommitState {
  final Commit lastCommit;

  const LastCommitSuccess(this.lastCommit);

  @override
  List<Object> get props => [lastCommit];
}

class LastCommitFailure extends LastCommitState {
  final FailureType type;

  const LastCommitFailure(this.type);

  @override
  List<Object> get props => [type];
}
