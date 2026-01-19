import '../networking/constant.dart';
import '../support/dio_helper.dart';

class NotificationService {


  static Future Notification(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/notifications',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

}