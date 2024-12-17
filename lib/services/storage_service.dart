import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/time_slot.dart';

class StorageService {
  static Future<void> saveData({
    required List<String> topPriorities,
    required List<String> brainDump,
    required DateTime selectedDate,
    required List<TimeSlot> timeSlots,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('topPriorities', topPriorities);
    await prefs.setStringList('brainDump', brainDump);
    await prefs.setString('selectedDate', selectedDate.toIso8601String());

    final timeSlotData = timeSlots.map((slot) {
      return jsonEncode({
        'time': slot.time,
        'fullHour': slot.fullHour ?? '',
        'halfHour': slot.halfHour ?? ''
      });
    }).toList();
    await prefs.setStringList('timeSlots', timeSlotData);
  }

  static Future<Map<String, dynamic>> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'topPriorities': prefs.getStringList('topPriorities') ??
          List.filled(3, "", growable: false),
      'brainDump': prefs.getStringList('brainDump') ?? ["Ex task"],
      'selectedDate': DateTime.parse(
          prefs.getString('selectedDate') ?? DateTime.now().toIso8601String()),
      'timeSlots': _loadTimeSlots(prefs),
    };
  }

  static List<TimeSlot> _loadTimeSlots(SharedPreferences prefs) {
    final timeSlotData = prefs.getStringList('timeSlots');
    if (timeSlotData != null && timeSlotData.isNotEmpty) {
      return timeSlotData.map((data) {
        try {
          return TimeSlot.fromJson(jsonDecode(data));
        } catch (e) {
          return TimeSlot(time: '0');
        }
      }).toList();
    }
    return List.generate(15, (index) => TimeSlot(time: (index + 5).toString()));
  }
}
