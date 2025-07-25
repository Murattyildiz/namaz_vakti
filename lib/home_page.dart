import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'prayer_time_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String city = "Istanbul";
  Map<String, String>? prayerTimes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCityAndTimes();
  }

  Future<void> loadCityAndTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedCity = prefs.getString('selectedCity');

    if (savedCity != null) {
      city = savedCity;
    }

    final times = await PrayerTimeService().fetchPrayerTimes(city);
    setState(() {
      prayerTimes = times;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Namaz Vakitleri - $city"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: prayerTimes!.length,
              itemBuilder: (context, index) {
                String key = prayerTimes!.keys.elementAt(index);
                String value = prayerTimes![key]!;
                return ListTile(
                  title: Text(key, style: TextStyle(fontSize: 20)),
                  trailing: Text(value, style: TextStyle(fontSize: 20)),
                );
              },
            ),
    );
  }
}
