// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `TimeBox`
  String get app_name {
    return Intl.message(
      'TimeBox',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Plan your day effectively`
  String get app_tagline {
    return Intl.message(
      'Plan your day effectively',
      name: 'app_tagline',
      desc: '',
      args: [],
    );
  }

  /// `Top Priorities`
  String get top_priorities {
    return Intl.message(
      'Top Priorities',
      name: 'top_priorities',
      desc: '',
      args: [],
    );
  }

  /// `Brain Dump`
  String get brain_dump {
    return Intl.message(
      'Brain Dump',
      name: 'brain_dump',
      desc: '',
      args: [],
    );
  }

  /// `Daily Schedule`
  String get daily_schedule {
    return Intl.message(
      'Daily Schedule',
      name: 'daily_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Enter new task`
  String get enter_new_task {
    return Intl.message(
      'Enter new task',
      name: 'enter_new_task',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Empty Slot`
  String get empty_slot {
    return Intl.message(
      'Empty Slot',
      name: 'empty_slot',
      desc: '',
      args: [],
    );
  }

  /// `Pick a date`
  String get pick_a_date {
    return Intl.message(
      'Pick a date',
      name: 'pick_a_date',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `:00`
  String get full_hour {
    return Intl.message(
      ':00',
      name: 'full_hour',
      desc: '',
      args: [],
    );
  }

  /// `:30`
  String get half_hour {
    return Intl.message(
      ':30',
      name: 'half_hour',
      desc: '',
      args: [],
    );
  }

  /// `Please choose the date`
  String get date {
    return Intl.message(
      'Please choose the date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Think about all what you can do in this day....`
  String get braindump {
    return Intl.message(
      'Think about all what you can do in this day....',
      name: 'braindump',
      desc: '',
      args: [],
    );
  }

  /// `What are your three top priorities?`
  String get toppriorities {
    return Intl.message(
      'What are your three top priorities?',
      name: 'toppriorities',
      desc: '',
      args: [],
    );
  }

  /// `Box your time for more efficiency`
  String get boxtime {
    return Intl.message(
      'Box your time for more efficiency',
      name: 'boxtime',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Top Priorities is full! Remove an item to add new ones.`
  String get priorities_full {
    return Intl.message(
      'Top Priorities is full! Remove an item to add new ones.',
      name: 'priorities_full',
      desc: '',
      args: [],
    );
  }

  /// `Added {task} to Top Priorities`
  String task_added_to_priorities(Object task) {
    return Intl.message(
      'Added $task to Top Priorities',
      name: 'task_added_to_priorities',
      desc: '',
      args: [task],
    );
  }

  /// `Select Language`
  String get select_language {
    return Intl.message(
      'Select Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get French {
    return Intl.message(
      'French',
      name: 'French',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar', countryCode: 'AR'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
