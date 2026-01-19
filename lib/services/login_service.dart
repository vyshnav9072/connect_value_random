
import '../networking/constant.dart';
import '../support/dio_helper.dart';

class LoginService {
  static Future login(data) async {
    var dio = await DioHelper.getInstance();
    var response = await dio.post('$baseURL/telecaller/login', data: data);
    return response.data;
  }
}
