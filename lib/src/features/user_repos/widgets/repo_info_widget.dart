import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repos/src/core/app/injection_container.dart';
import 'package:github_repos/src/core/extension/context_extension.dart';
import 'package:github_repos/src/core/views/atomic/atoms/padding.dart';

import '../bloc/last_commit/last_commit_bloc.dart';
import '../models/repos_model.dart';

class RepoInfoWidget extends StatelessWidget {
  const RepoInfoWidget({
    Key? key,
    required this.repo,
  }) : super(key: key);

  final Repos repo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LastCommitBloc(
        repository: sl(),
      )..add(
          GetLastCommit(repo.title),
        ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repo.title,
                          style: context.theme.textTheme.titleMedium,
                        ),
                        if (repo.description != null)
                          Text(
                            repo.description!,
                            style: context.theme.textTheme.bodyMedium,
                          ),
                        padding4,
                        if (repo.language != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.theme.highlightColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              repo.language!.toUpperCase(),
                              style: context.theme.textTheme.labelMedium,
                            ),
                          ),
                      ],
                    ),
                  ),
                  padding12,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: repo.owner.imageUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              padding12,
              const Text('Last commit : '),
              BlocBuilder<LastCommitBloc, LastCommitState>(
                builder: (context, state) {
                  if (state is LastCommitLoading) {
                    return const Text('Loading...');
                  } else if (state is LastCommitSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.lastCommit.message),
                        Text(
                          "${state.lastCommit.committer} on ${state.lastCommit.dateTime}",
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
