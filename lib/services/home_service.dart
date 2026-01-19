
import '../networking/constant.dart';
import '../support/dio_helper.dart';

class HomeService {

  static Future homegrid(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL//telecaller/home', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

}
