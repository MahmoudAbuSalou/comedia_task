

import '../helper/route_helper.dart';

class ApiChecker {
  static void checkApi( response, {bool getXSnackBar = false}) {
    if(response.statusCode == 401) {
      // remove token from shared preferense and goto initial page
      RouteHelper.goWeatherScreenAndReplaceAll();
    }else {

    }
  }
}
