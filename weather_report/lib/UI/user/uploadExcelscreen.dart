import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:weather_report/UI/helper/Customsnackbar.dart';
import 'package:weather_report/services/ExcelServices.dart';


class UploadExcelScreen extends StatefulWidget {
  @override
  _UploadExcelScreenState createState() => _UploadExcelScreenState();
}

class _UploadExcelScreenState extends State<UploadExcelScreen> {
  void _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      log("excel is not null, starting processFile...");
      await ExcelService.processFile(file.path!,context);
      log("processFile completed.");
      Customsnackbar.showSuccess("Uploaded sucessfully", context);
    } else {
      Customsnackbar.showError("file is not uploaded", context);
      log("No file selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Excel File'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Pick Excel File'),
          onPressed:()
          {
            _pickFile(context);
          }
        ),
      ),
    );
  }
}
