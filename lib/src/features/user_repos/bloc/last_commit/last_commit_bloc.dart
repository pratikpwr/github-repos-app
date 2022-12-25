import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/commit_model.dart';
import '../../repository/repos_repository.dart';

part 'last_commit_event.dart';
part 'last_commit_state.dart';

class LastCommitBloc extends Bloc<LastCommitEvent, LastCommitState> {
  final ReposRepository repository;

  LastCommitBloc({
    required this.repository,
  }) : super(LastCommitInitial()) {
    on<GetLastCommit>(_onGetLastCommitEvent);
  }

  void _onGetLastCommitEvent(
    GetLastCommit event,
    Emitter<LastCommitState> emit,
  ) async {
    emit(LastCommitLoading());

    final result = await repository.lastCommit(
      repoName: event.repoName,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(
        LastCommitFailure(
          FailureType.fromFailure(failure),
        ),
      ),
      (commit) => emit(
        LastCommitSuccess(commit),
      ),
    );
  }
}
