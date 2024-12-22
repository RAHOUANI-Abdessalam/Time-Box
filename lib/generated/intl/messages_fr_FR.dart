// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr_FR locale. All the
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
  String get localeName => 'fr_FR';

  static String m0(task) => "${task} ajouté aux Priorités Principales";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Arabic": MessageLookupByLibrary.simpleMessage("Arabe"),
        "English": MessageLookupByLibrary.simpleMessage("Anglais"),
        "French": MessageLookupByLibrary.simpleMessage("Français"),
        "add": MessageLookupByLibrary.simpleMessage("Ajouter"),
        "app_name": MessageLookupByLibrary.simpleMessage("TimeBox"),
        "app_tagline":
            MessageLookupByLibrary.simpleMessage("Planifiez votre journée"),
        "boxtime": MessageLookupByLibrary.simpleMessage(
            "Organisez votre temps pour plus d\'efficacité"),
        "brain_dump": MessageLookupByLibrary.simpleMessage("Déversoir Mental"),
        "braindump": MessageLookupByLibrary.simpleMessage(
            "Réfléchissez à tout ce que vous pouvez faire dans cette journée...."),
        "daily_schedule":
            MessageLookupByLibrary.simpleMessage("Emploi du Temps Quotidien"),
        "date":
            MessageLookupByLibrary.simpleMessage("Veuillez choisir une date"),
        "done": MessageLookupByLibrary.simpleMessage("Terminé"),
        "empty_slot": MessageLookupByLibrary.simpleMessage("Emplacement Vide"),
        "enter_new_task":
            MessageLookupByLibrary.simpleMessage("Entrer une nouvelle tâche"),
        "finish": MessageLookupByLibrary.simpleMessage("Terminer"),
        "full_hour": MessageLookupByLibrary.simpleMessage(":00"),
        "half_hour": MessageLookupByLibrary.simpleMessage(":30"),
        "next": MessageLookupByLibrary.simpleMessage("Suivant"),
        "pick_a_date":
            MessageLookupByLibrary.simpleMessage("Choisissez une date"),
        "priorities_full": MessageLookupByLibrary.simpleMessage(
            "Les Priorités Principales sont pleines ! Supprimez un élément pour en ajouter."),
        "select_language":
            MessageLookupByLibrary.simpleMessage("Sélectionner la langue"),
        "task_added_to_priorities": m0,
        "time": MessageLookupByLibrary.simpleMessage("Heure"),
        "top_priorities":
            MessageLookupByLibrary.simpleMessage("Priorités Principales"),
        "toppriorities": MessageLookupByLibrary.simpleMessage(
            "Quelles sont vos trois principales priorités ?")
      };
}
