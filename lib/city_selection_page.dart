import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'location_service.dart'; // Konum servisi için eklendi

class CitySelectionPage extends StatefulWidget {
  @override
  _CitySelectionPageState createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  String? selectedCity;
  List<String> cities = [
    'Istanbul',
    'Ankara',
    'Izmir',
    'Bursa',
    'Antalya',
    'Konya',
    'Gaziantep',
    'Kayseri',
    'Adana',
    'Trabzon'
  ];

  Future<void> saveCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCity', city);
  }

  void goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şehir Seçimi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text("Şehir seçin"),
              value: selectedCity,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
              items: cities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: selectedCity == null
                  ? null
                  : () async {
                      await saveCity(selectedCity!);
                      goToHome();
                    },
              child: Text("Kaydet ve Devam Et"),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              icon: Icon(Icons.my_location),
              label: Text("Konumdan Şehri Al"),
              onPressed: () async {
                String? locationCity = await LocationService().getCityFromLocation();

                if (locationCity != null && cities.contains(locationCity)) {
                  setState(() {
                    selectedCity = locationCity;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Konumdan şehir alındı: $locationCity")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Şehir bulunamadı ya da desteklenmiyor")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
