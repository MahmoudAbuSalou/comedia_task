import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common/controllers/theme_controller.dart';
import '../controller/weather_controller.dart';


class WeatherScreen extends StatelessWidget {
  static const routeName = "/weather";

  // Get both controllers
  final WeatherController weatherController = Get.find();
  final ThemeController themeController = Get.find(); // Get the ThemeController instance

  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Theme.of(context) to get current theme data
    final textTheme = Theme.of(context).textTheme;
    final iconTheme = Theme.of(context).iconTheme;
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).hintColor; // Use hintColor as accent

    return Scaffold(
      body: Obx(() { // Obx to react to themeController's themeMode changes for background gradient
        return Container(
          // Background gradient for a nice visual effect, now reacting to themeMode
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: themeController.themeMode == ThemeMode.light
                  ? [
                const Color(0xFF8EC5FC), // Light Blue
                const Color(0xFFE0C3FC), // Light Purple
              ]
                  : [
                const Color(0xFF2D3748), // Dark gradient start (adjust as per your darkTheme's background)
                const Color(0xFF1A202C), // Dark gradient end
              ],
            ),
          ),
          child: Obx(() {
            switch (weatherController.status.value) {
              case WeatherStatus.loading:
              case WeatherStatus.initial: // Treat initial and loading similarly
                return Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).progressIndicatorTheme.color, // Use theme color
                        strokeWidth: 3.w)); // Responsive stroke width

              case WeatherStatus.error:
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w), // Responsive padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            color: iconTheme.color, // Use theme icon color
                            size: 60.r), // Responsive icon size
                        SizedBox(height: 20.h), // Responsive height
                        Text(
                          weatherController.errorMessage.value.isNotEmpty
                              ? weatherController.errorMessage.value
                              : 'An error occurred while fetching weather data. Please try again.',
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium!.copyWith(
                              color: textTheme.bodyMedium!.color, // Use theme text color
                              fontSize: 18.sp), // Responsive font size
                        ),
                        SizedBox(height: 30.h), // Responsive height
                        ElevatedButton.icon(
                          onPressed: () => weatherController.getLocationAndWeather(),
                          icon: Icon(Icons.refresh, size: 24.r), // Responsive icon size
                          label: Text('Refresh', style: TextStyle(fontSize: 16.sp)), // Responsive font size
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.onPrimary, // Example direct color from theme
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h), // Responsive padding
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)), // Responsive border radius
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              case WeatherStatus.loaded:
                final weather = weatherController.weather!;
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(25.w), // Responsive padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Row( // Use a Row to place multiple action buttons
                            mainAxisSize: MainAxisSize.min, // To make the row only as wide as its children
                            children: [
                              IconButton(
                                icon: Icon(Icons.refresh, color: iconTheme.color, size: 30.r), // Responsive icon size
                                onPressed: () => weatherController.getLocationAndWeather(),
                              ),
                              SizedBox(width: 10.w), // Spacer between buttons
                              // New Theme Change Button
                              IconButton(
                                icon: Icon(
                                  themeController.themeMode == ThemeMode.light
                                      ? Icons.dark_mode // Show dark mode icon in light theme
                                      : Icons.light_mode, // Show light mode icon in dark theme
                                  color: iconTheme.color, // Use theme icon color
                                  size: 30.r, // Responsive icon size
                                ),
                                onPressed: () => themeController.toggleTheme(), // Call toggleTheme
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h), // Responsive height

                        // Location
                        Text(
                          '${weather.location.name}, ${weather.location.country}',
                          style: textTheme.displayLarge!.copyWith(
                            fontSize: 32.sp, // Responsive font size
                            fontWeight: FontWeight.bold,
                            color: textTheme.displayLarge!.color, // Use theme text color
                            shadows: [
                              Shadow(
                                blurRadius: 10.0.r, // Responsive blur radius
                                color: Colors.black38,
                                offset: Offset(2.0.w, 2.0.h), // Responsive offset
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h), // Responsive height
                        // Last Updated Timestamp
                        if (weather.current.lastUpdated != null)
                          Text(
                            'Last updated: ${weather.current.lastUpdated}',
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 16.sp, // Responsive font size
                              color: textTheme.bodyMedium!.color, // Use theme text color
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        SizedBox(height: 30.h), // Responsive height

                        // Current Temperature and Condition
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Weather Icon with subtle border
                            Container(
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(15.r), // Responsive border radius
                                border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.w), // Responsive border width
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r), // Responsive border radius
                                child: CachedNetworkImage( // Using CachedNetworkImage
                                  imageUrl: "https:${weather.current.condition.icon}",
                                  width: 90.w, // Responsive width
                                  height: 90.h, // Responsive height
                                  fit: BoxFit.cover,
                                  key: Key("https:${weather.current.condition.icon}"),
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator(strokeWidth: 2.w, color: Theme.of(context).progressIndicatorTheme.color)), // Placeholder with theme color
                                  errorWidget: (context, url, error) => Icon(Icons.cloud, size: 90.r, color: iconTheme.color), // Fallback icon with theme color
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w), // Responsive width
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Animated Temperature
                                TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0, end: weather.current.tempC),
                                  duration: const Duration(milliseconds: 800),
                                  builder: (context, value, child) {
                                    return Text(
                                      '${value.toStringAsFixed(0)}°C',
                                      style: textTheme.displayLarge!.copyWith(
                                        fontSize: 70.sp, // Responsive font size
                                        fontWeight: FontWeight.w300,
                                        color: textTheme.displayLarge!.color, // Use theme text color
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0.r, // Responsive blur radius
                                            color: Colors.black38,
                                            offset: Offset(2.0.w, 2.0.h), // Responsive offset
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  weather.current.condition.text,
                                  style: textTheme.displayMedium!.copyWith(
                                    fontSize: 24.sp, // Responsive font size
                                    color: textTheme.displayMedium!.color, // Use theme text color
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h), // Responsive height

                        // Weather Details Card
                        Card(
                          color: Theme.of(context).cardTheme.color, // Use theme card color
                          elevation: Theme.of(context).cardTheme.elevation, // Use theme elevation
                          shape: Theme.of(context).cardTheme.shape, // Use theme shape
                          child: Padding(
                            padding: EdgeInsets.all(20.w), // Responsive padding
                            child: Column(
                              children: [
                                _buildDetailRow(context,
                                    Icons.water_drop, 'Humidity', '${weather.current.humidity}%'),
                                _buildDetailRow(context,
                                    Icons.wind_power, 'Wind', '${weather.current.windKph} km/h'),
                                _buildDetailRow(context, Icons.thermostat,
                                    'Feels Like', '${weather.current.feelslikeC.toStringAsFixed(0)}°C'),
                                _buildDetailRow(context, Icons.air,
                                    'Air Quality (EPA)', '${_getEpaIndexText(weather.current.airQuality.usEpaIndex)}'),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(), // Pushes content to the top
                        // Optional: Add a footer or attribution here if needed
                      ],
                    ),
                  ),
                );
            }
          }),
        );
      }),
    );
  }

  // Helper method to build a detail row
  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    final iconTheme = Theme.of(context).iconTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h), // Responsive padding
      child: Row(
        children: [
          Icon(icon, color: iconTheme.color, size: 28.r), // Use theme icon color
          SizedBox(width: 15.w), // Responsive width
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyLarge!.copyWith(
                fontSize: 18.sp, // Responsive font size
                color: textTheme.bodyLarge!.color, // Use theme text color
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            value,
            style: textTheme.titleMedium!.copyWith(
              fontSize: 18.sp, // Responsive font size
              color: textTheme.titleMedium!.color, // Use theme text color
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for EPA index text
  String _getEpaIndexText(int index) {
    switch (index) {
      case 1: return 'Good';
      case 2: return 'Moderate';
      case 3: return 'Unhealthy for Sensitive Groups';
      case 4: return 'Unhealthy';
      case 5: return 'Very Unhealthy';
      case 6: return 'Hazardous';
      default: return 'N/A';
    }
  }
}