import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/util/app_constants.dart';

import 'api/api_client.dart';
import 'common/controllers/theme_controller.dart';
import 'features/weather/domain/repositories/weather_repository.dart';
import 'features/weather/domain/repositories/weather_repository_interface.dart';
import 'features/weather/domain/services/weather_service.dart';
import 'features/weather/domain/services/weather_service_interface.dart';
import 'features/weather/presentation/controller/weather_controller.dart';


class GetDI {
  static  init() async{
    /// Core
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));


    /// repo
    WeatherRepositoryInterface weatherRepositoryInterface = WeatherRepository(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => weatherRepositoryInterface);


    /// services
    WeatherServiceInterface checkoutServiceInterface = WeatherService(weatherRepositoryInterface: Get.find());
    Get.lazyPut(() => checkoutServiceInterface);

    /// controller
    Get.put<ThemeController>(ThemeController(sharedPreferences: Get.find() ));
    Get.put<WeatherController>(WeatherController( weatherServiceInterface: Get.find(),));
  }
}

