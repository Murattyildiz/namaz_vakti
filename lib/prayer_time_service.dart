import 'dart:convert';
import 'package:http/http.dart' as http;

class PrayerTimeService {
  Future<Map<String, String>> fetchPrayerTimes(String city) async {
    final url = Uri.parse(
      'https://api.aladhan.com/v1/timingsByCity?city=$city&country=Turkey&method=13',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final timings = data['data']['timings'];

      return {
        "İmsak": timings['Fajr'],
        "Güneş": timings['Sunrise'],
        "Öğle": timings['Dhuhr'],
        "İkindi": timings['Asr'],
        "Akşam": timings['Maghrib'],
        "Yatsı": timings['Isha'],
      };
    } else {
      throw Exception('Namaz vakitleri alınamadı');
    }
  }
}
