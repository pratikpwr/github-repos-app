import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/views/widgets/failure_view.dart';
import '../../../core/views/widgets/loader.dart';
import '../../../core/views/widgets/unknown_state.dart';
import '../bloc/user_repos/user_repos_bloc.dart';
import '../widgets/repo_info_widget.dart';

const userName = "pratikpwr";

class ReposScreen extends StatelessWidget {
  const ReposScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserReposBloc(repository: sl())
        ..add(
          const GetUserRepos(userName),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Repositories'),
        ),
        body: BlocBuilder<UserReposBloc, UserReposState>(
          builder: (context, state) {
            if (state is UserReposLoading) {
              return const Center(
                child: Loader(),
              );
            }
            if (state is UserReposSuccess) {
              return RefreshIndicator(
                onRefresh: () async => context.read<UserReposBloc>()
                  ..add(
                    const GetUserRepos(userName),
                  ),
                child: ListView.builder(
                  itemCount: state.projects.length,
                  itemBuilder: (context, index) {
                    final repo = state.projects[index];
                    return RepoInfoWidget(repo: repo);
                  },
                ),
              );
            }
            if (state is UserReposFailure) {
              return FailureView(
                type: state.type,
                onRetry: () => context.read<UserReposBloc>()
                  ..add(
                    const GetUserRepos(userName),
                  ),
              );
            }
            return const UnKnownState();
          },
        ),
      ),
    );
  }
}
