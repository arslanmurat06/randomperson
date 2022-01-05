import 'package:randomperson/models/user.dart';

abstract class IUserService {
  Future<User> getRandomUser();
}
