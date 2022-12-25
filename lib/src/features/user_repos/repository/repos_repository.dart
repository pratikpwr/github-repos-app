import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_repos/src/core/enums/http_method.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/network_info.dart';
import '../models/commit_model.dart';
import '../models/repos_model.dart';

abstract class ReposRepository {
  Future<Either<Failure, List<Repos>>> userRepos({required String userName});

  Future<Either<Failure, Commit>> lastCommit({required String repoName});
}

class ProjectRepositoryImpl implements ReposRepository {
  final NetworkInfo networkInfo;
  final ApiClient apiClient;

  const ProjectRepositoryImpl({
    required this.networkInfo,
    required this.apiClient,
  });

  @override
  Future<Either<Failure, List<Repos>>> userRepos({
    required String userName,
  }) async {
    if (await networkInfo.isConnected) {
      final userReposUrl = "https://api.github.com/users/$userName/repos";

      final result = await apiClient.request(HttpMethod.get, userReposUrl);

      try {
        if ((result.data as List).isEmpty) {
          return const Left(NoDataFailure());
        }

        final repos = List<Repos>.from(
          result.data.map(
            (item) => Repos.fromJson(item),
          ),
        );
        return Right(repos);
      } catch (e) {
        debugPrint(e.toString());
        return Left(InternalFailure(e.toString()));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Commit>> lastCommit({
    required String repoName,
  }) async {
    if (await networkInfo.isConnected) {
      final userReposUrl =
          "https://api.github.com/repos/pratikpwr/$repoName/commits";

      try {
        final result = await apiClient.request(HttpMethod.get, userReposUrl);

        if ((result.data as List).isEmpty) {
          return const Left(NoDataFailure());
        }

        final commit = Commit.fromJson(result.data[0]);
        return Right(commit);
      } on DioError {
        return const Left(InternalFailure('Dio Error'));
      } catch (e) {
        debugPrint(e.toString());
        return Left(InternalFailure(e.toString()));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
