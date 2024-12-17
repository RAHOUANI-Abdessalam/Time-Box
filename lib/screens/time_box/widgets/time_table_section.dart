import 'package:flutter/material.dart';
import 'package:time_box/utils/helpers/helpers.dart';
import '../../../models/time_slot.dart';

class TimeTableSection extends StatelessWidget {
  final List<TimeSlot> timeSlots;
  final Function(List<TimeSlot>) onUpdate;

  const TimeTableSection({
    super.key,
    required this.timeSlots,
    required this.onUpdate,
  });

  void _updateTimeSlot(int index, String? value, bool isFullHour) {
    List<TimeSlot> newTimeSlots = List.from(timeSlots);
    if (isFullHour) {
      newTimeSlots[index].fullHour = value;
    } else {
      newTimeSlots[index].halfHour = value;
    }
    onUpdate(newTimeSlots);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Daily Schedule",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Table(
                border: TableBorder.all(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(0.8),
                  1: FlexColumnWidth(1.2),
                  2: FlexColumnWidth(1.2),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    children: [
                      _buildHeaderCell(context, "Time"),
                      _buildHeaderCell(context, ":00"),
                      _buildHeaderCell(context, ":30"),
                    ],
                  ),
                  ...List.generate(
                    timeSlots.length,
                    (index) => _buildTimeSlotRow(context, index),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.all(getPadding(context, 12)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: getFontSize(context, 14)),
        ),
      ),
    );
  }

  TableRow _buildTimeSlotRow(BuildContext context, int index) {
    final slot = timeSlots[index];
    return TableRow(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.grey.shade50 : Colors.white,
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              slot.time,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        _buildTimeInputCell(context, index, slot.fullHour, true),
        _buildTimeInputCell(context, index, slot.halfHour, false),
      ],
    );
  }

  Widget _buildTimeInputCell(
      BuildContext context, int index, String? initialValue, bool isFullHour) {
    return Container(
      height: MediaQuery.of(context).size.width < 600 ? 35 : 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        initialValue: initialValue ?? '',
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        textAlign: TextAlign.center,
        onChanged: (value) => _updateTimeSlot(index, value, isFullHour),
      ),
    );
  }
}
