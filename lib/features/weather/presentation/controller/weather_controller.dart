import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../domain/models/weather_model.dart';
import '../../domain/services/weather_service_interface.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherController extends GetxController {
  final WeatherServiceInterface weatherServiceInterface ;
  bool test=false;
  WeatherController({required this.weatherServiceInterface,this.test=false});
  var status = WeatherStatus.initial.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if(!test) {
      getCurrentLocation().then((value){
      Map<String, dynamic> query = {
        'key': '152492e614e3425592c153522252107', // Replace with your actual key
        'q': '${value.latitude},${value.longitude}', // lat,long format
        'aqi': 'yes' // Optional: to include air_quality info
      };
      fetchWeather(query);
    });
    }

  }
  WeatherResponse? weather;

  Future<void> fetchWeather(Map<String, dynamic> query) async {
    try {
      status.value = WeatherStatus.loading;

      // Simulate delay and success
      final   WeatherResponse  res=await weatherServiceInterface.fetchWeather(query);
      weather=res;

      // Set to loaded (or use actual API response logic)
      status.value = WeatherStatus.loaded;
    } catch (e) {
      errorMessage.value = 'An error occurred';
      status.value = WeatherStatus.error;
    }
  }
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // إذا كانت الخدمة غير مفعّلة، نطلب من المستخدم تمكينها
    while (!serviceEnabled) {
      final result = await Get.defaultDialog(
        title: 'خدمة الموقع غير مفعلة',
        middleText: 'يرجى تفعيل الموقع من الإعدادات.',
        textConfirm: 'فتح الإعدادات',
        textCancel: 'إلغاء',
        onConfirm: () {
          Geolocator.openLocationSettings();
          Get.back();
        },
      );

      await Future.delayed(const Duration(seconds: 2));
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      final result = await Get.defaultDialog(
        title: 'الصلاحية مرفوضة',
        middleText: 'يرجى منح صلاحية الوصول إلى الموقع.',
        textConfirm: 'فتح الإعدادات',
        textCancel: 'إلغاء',
        onConfirm: () {
          Geolocator.openAppSettings();
          Get.back();
        },
      );
      throw Exception('تم رفض صلاحية الموقع.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
  void getLocationAndWeather(){
    getCurrentLocation().then((value){
      Map<String, dynamic> query = {
        'key': '152492e614e3425592c153522252107', // Replace with your actual key
        'q': '${value.latitude},${value.longitude}', // lat,long format
        'aqi': 'yes' // Optional: to include air_quality info
      };
      fetchWeather(query);
    });
  }


}
