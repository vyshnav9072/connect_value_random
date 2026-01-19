import '../networking/constant.dart';
import '../support/dio_helper.dart';

class ProfileService {

  static Future profilePage(name) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL//telecaller/profile/$name');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

}