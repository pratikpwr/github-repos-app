import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/user_repos/bloc/user_repos/user_repos_bloc.dart';
import '../../features/user_repos/repository/repos_repository.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory<UserReposBloc>(() => UserReposBloc(repository: sl()));

  // repository
  sl.registerLazySingleton<ReposRepository>(() => ProjectRepositoryImpl(
        networkInfo: sl(),
        apiClient: sl(),
      ));

  // core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(dataConnectionChecker: sl()));
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl(dio: sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
