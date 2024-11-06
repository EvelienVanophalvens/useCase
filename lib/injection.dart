import 'dart:async';
import 'package:demo/injection.config.dart';
import 'package:demo/repositories/blog_repository.dart';
import 'package:demo/repositories/blog_repository_impl.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
FutureOr<void> configureInjection() {
  getIt.registerLazySingleton<BlogRepository>(() => BlogRepositoryImpl());

  init(getIt);
}