// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(task) => "Added ${task} to Top Priorities";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
        "English": MessageLookupByLibrary.simpleMessage("English"),
        "French": MessageLookupByLibrary.simpleMessage("French"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "app_name": MessageLookupByLibrary.simpleMessage("TimeBox"),
        "app_tagline":
            MessageLookupByLibrary.simpleMessage("Plan your day effectively"),
        "boxtime": MessageLookupByLibrary.simpleMessage(
            "Box your time for more efficiency"),
        "brain_dump": MessageLookupByLibrary.simpleMessage("Brain Dump"),
        "braindump": MessageLookupByLibrary.simpleMessage(
            "Think about all what you can do in this day...."),
        "daily_schedule":
            MessageLookupByLibrary.simpleMessage("Daily Schedule"),
        "date": MessageLookupByLibrary.simpleMessage("Please choose the date"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "empty_slot": MessageLookupByLibrary.simpleMessage("Empty Slot"),
        "enter_new_task":
            MessageLookupByLibrary.simpleMessage("Enter new task"),
        "finish": MessageLookupByLibrary.simpleMessage("Finish"),
        "full_hour": MessageLookupByLibrary.simpleMessage(":00"),
        "half_hour": MessageLookupByLibrary.simpleMessage(":30"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "pick_a_date": MessageLookupByLibrary.simpleMessage("Pick a date"),
        "priorities_full": MessageLookupByLibrary.simpleMessage(
            "Top Priorities is full! Remove an item to add new ones."),
        "select_language":
            MessageLookupByLibrary.simpleMessage("Select Language"),
        "task_added_to_priorities": m0,
        "time": MessageLookupByLibrary.simpleMessage("Time"),
        "top_priorities":
            MessageLookupByLibrary.simpleMessage("Top Priorities"),
        "toppriorities": MessageLookupByLibrary.simpleMessage(
            "What are your three top priorities?")
      };
}
