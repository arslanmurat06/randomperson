import 'package:dio/dio.dart';
import 'package:randomperson/models/user.dart';
import 'package:randomperson/services/api/api_paths.dart';
import 'package:randomperson/services/iuserservice.dart';

class UserService extends IUserService {
  late Dio network;

  UserService() {
    network = Dio();
  }

  @override
  Future<User> getRandomUser() async {
    late User user;

    var response = await network.get(UserAPIPath.base).then((result) {
      user = User.fromJson(result.data['results'][0]);
    }).catchError((e) => throw e);
    return user;
  }
}
