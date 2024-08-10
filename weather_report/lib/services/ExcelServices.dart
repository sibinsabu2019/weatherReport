import 'dart:io';
import 'dart:developer';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:weather_report/services/Weatherservices.dart';



class ExcelService {

  static Future<void> processFile(String filePath,BuildContext context)async {
    try {
      log("Starting to process file...");
      var file = File(filePath);
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]?.rows ?? []) {
          if (row.length >= 4) {
            String country = row[0]?.value.toString() ?? '';
            String state = row[1]?.value.toString() ?? '';
            String district = row[2]?.value.toString() ?? '';
            String city = row[3]?.value.toString() ?? '';

            log("Processing weather for: $city");
            await WeatherService().fetchWeather(country, state, district, city,context);
          } else {
            log("Row does not have enough columns: $row");
          }
        }
      }
    } catch (e) {
      log("Error processing file: $e");
    }
  }
}
