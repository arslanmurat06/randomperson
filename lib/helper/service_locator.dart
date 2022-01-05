import 'package:get_it/get_it.dart';
import 'package:randomperson/services/iuserservice.dart';
import 'package:randomperson/services/userservice.dart';

final serviceLocator = GetIt.instance;

initServices() {
  serviceLocator.registerLazySingleton<IUserService>(() => UserService());
}
