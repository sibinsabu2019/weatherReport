
class Weather {
  String? name;
  String? region;
  String? country;
  List<HourlyWeather>? hourlyWeather;

  Weather({this.name, this.region, this.country, this.hourlyWeather});

  factory Weather.fromJson(Map<String, dynamic> json) {
    var hourlyWeatherJson = json['forecast']['forecastday'][0]['hour'] as List;
    List<HourlyWeather> hourlyWeatherList = hourlyWeatherJson.map((hourJson) {
      return HourlyWeather.fromJson(hourJson);
    }).toList();

    return Weather(
      name: json['location'] != null ? json['location']['name'] : null,
      region: json['location'] != null ? json['location']['region'] : null,
      country: json['location'] != null ? json['location']['country'] : null,
      hourlyWeather: hourlyWeatherList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'hourlyWeather': hourlyWeather?.map((hour) => hour.toJson()).toList(),
    };
  }
}

class HourlyWeather {
  String? time;
  double? tempC;

  HourlyWeather({this.time, this.tempC});

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: json['time'],
      tempC: (json['temp_c'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temp_c': tempC,
    };
  }
}
