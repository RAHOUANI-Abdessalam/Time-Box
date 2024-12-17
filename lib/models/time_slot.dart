class TimeSlot {
  final String time;
  String? fullHour;
  String? halfHour;

  TimeSlot({
    required this.time,
    this.fullHour,
    this.halfHour,
  });

  Map<String, dynamic> toJson() => {
        'time': time,
        'fullHour': fullHour,
        'halfHour': halfHour,
      };

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      time: json['time'],
      fullHour: json['fullHour'],
      halfHour: json['halfHour'],
    );
  }
}
