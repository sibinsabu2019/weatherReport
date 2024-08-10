import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_report/UI/user/weather/layoutScreen.dart';
import 'package:weather_report/provider/userprovider/UserProvider.dart';

class screen3 extends StatelessWidget {
  const screen3({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherDataProvider = Provider.of<Userprovider>(context);

    return Scaffold(
      
      body: Column(
        children: [
          const Text("Weather Data base on Your Excel file ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
          Expanded(
            
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: weatherDataProvider.fetchWeatherData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data found'));
                } else {
                  final weatherData = snapshot.data!;
                  return ListView.builder(
                    itemCount: weatherData.length,
                    itemBuilder: (context, index) {
                      final countryData = weatherData[index];
                      String countryName = countryData['country'];
                      String StateName = countryData['region'];
                      String cityName = countryData['name'];
                       List<dynamic> reducedHourlyWeatherData =
                          countryData['hourlyWeather'].sublist(0, countryData['hourlyWeather'].length - 17);
            
                      
            
                      return ListTile(
                        title: Text(countryName),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherDetailScreen(
                                StateName: StateName,
                                cityName: cityName,
                                countryName: countryName,
                                hourlyWeatherData: reducedHourlyWeatherData,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
