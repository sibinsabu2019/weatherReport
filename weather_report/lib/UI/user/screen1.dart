import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_report/provider/userprovider/UserProvider.dart';
import 'package:weather_report/UI/user/uploadExcelscreen.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Image(
                image: NetworkImage("https://imgs.search.brave.com/q30mtGI6Uq8L1sU9H02hXDiETyRoSxEtuLtXNNmTvSw/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9wbHVz/cG5nLmNvbS9pbWct/cG5nL3VzZXItcG5n/LWljb24teW91bmct/dXNlci1pY29uLTI0/MDAucG5n"),
                fit: BoxFit.cover,
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: Provider.of<Userprovider>(context, listen: false).fetchUserData(),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${data['name'] ?? 'No Name'}', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text('Email: ${data['email'] ?? 'No Email'}', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  );
                }

                return const Center(child: Text('No data found'));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: const Text('Upload Excel File'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  UploadExcelScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}
