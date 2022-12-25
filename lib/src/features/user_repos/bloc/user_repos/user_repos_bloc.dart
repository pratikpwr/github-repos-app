import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/repos_model.dart';
import '../../repository/repos_repository.dart';

part 'user_repos_event.dart';
part 'user_repos_state.dart';

class UserReposBloc extends Bloc<UserReposEvent, UserReposState> {
  final ReposRepository repository;

  UserReposBloc({
    required this.repository,
  }) : super(UserReposInitial()) {
    on<GetUserRepos>(_onUserReposEvent);
  }

  void _onUserReposEvent(
    GetUserRepos event,
    Emitter<UserReposState> emit,
  ) async {
    emit(UserReposLoading());

    final result = await repository.userRepos(
      userName: event.userName,
    );

    result.fold(
      (failure) => emit(
        UserReposFailure(
          FailureType.fromFailure(failure),
        ),
      ),
      (projects) => emit(
        UserReposSuccess(projects),
      ),
    );
  }
}
