import 'package:flutter/material.dart';
import 'time_slot.dart';

class TimeBoxModel extends ChangeNotifier {
  List<String> _topPriorities = List.filled(3, "", growable: false);
  List<String> _brainDump = ["Ex task"];
  List<TimeSlot> _timeSlots = [];
  DateTime _selectedDate = DateTime.now();

  List<String> get topPriorities => _topPriorities;
  List<String> get brainDump => _brainDump;
  List<TimeSlot> get timeSlots => _timeSlots;
  DateTime get selectedDate => _selectedDate;

  void updateTopPriorities(List<String> newPriorities) {
    _topPriorities = newPriorities;
    notifyListeners();
  }

  void updateBrainDump(List<String> newBrainDump) {
    _brainDump = newBrainDump;
    notifyListeners();
  }

  void updateTimeSlots(List<TimeSlot> newTimeSlots) {
    _timeSlots = newTimeSlots;
    notifyListeners();
  }

  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}
