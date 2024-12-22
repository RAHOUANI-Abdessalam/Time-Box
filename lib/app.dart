import 'package:flutter/material.dart';
import 'package:time_box/screens/time_box/time_box_screen.dart';
import 'package:time_box/services/storage_service.dart';
import 'package:time_box/utils/themes/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:time_box/generated/l10n.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale = const Locale("en"); // Default locale set to English

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  // Function to update the locale dynamically
  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Future<void> _loadSavedLanguage() async {
    final savedLanguage = await StorageService.loadLanguage();
    setState(() {
      _locale = Locale(savedLanguage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // onGenerateTitle: (BuildContext context) => S.of(context).app_name,
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      locale: _locale, // Locale updated dynamically
      darkTheme: AppTheme.darkTheme,
      // theme: ThemeData(
      //   useMaterial3: false,
      //   colorSchemeSeed: Colors.blue,
      //   brightness: Brightness.light,
      // ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: TimeBoxScreen(
        onLanguageChanged: _setLocale,
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class TimeSlot {
//   final String time;
//   String? fullHour;
//   String? halfHour;

//   TimeSlot({
//     required this.time,
//     this.fullHour,
//     this.halfHour,
//   });

//   Map<String, dynamic> toJson() => {
//         'time': time,
//         'fullHour': fullHour,
//         'halfHour': halfHour,
//       };

//   factory TimeSlot.fromJson(Map<String, dynamic> json) {
//     return TimeSlot(
//       time: json['time'],
//       fullHour: json['fullHour'],
//       halfHour: json['halfHour'],
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: Colors.blue,
//         brightness: Brightness.light,
//       ),
//       home: const TimeBoxScreen(),
//     );
//   }
// }

// class TimeBoxScreen extends StatefulWidget {
//   const TimeBoxScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _TimeBoxScreenState createState() => _TimeBoxScreenState();
// }

// class _TimeBoxScreenState extends State<TimeBoxScreen>
//     with SingleTickerProviderStateMixin {
//   List<String> topPriorities = List.filled(3, "", growable: false);
//   String selectedTable = "";
//   late AnimationController _animationController;
//   // ignore: unused_field
//   late Animation<double> _animation;
//   final TextEditingController _newTaskController = TextEditingController();

//   DateTime selectedDate = DateTime.now();
//   final TextEditingController _dateController = TextEditingController();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         _dateController.text =
//             "${picked.day} / ${_getMonth(picked.month)} / ${picked.year}";
//       });
//       // Save data after date change
//       await _saveData();
//     }
//   }

//   String _getMonth(int month) {
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     return months[month - 1];
//   }

//   void _addNewTask() {
//     final newTask = _newTaskController.text.trim();
//     if (newTask.isNotEmpty) {
//       setState(() {
//         brainDump.add(newTask);
//         _newTaskController.clear();
//       });
//       _saveData();
//     }
//   }

//   void _deleteTask(int index) {
//     setState(() {
//       brainDump.removeAt(index);
//     });
//     _saveData();
//   }

//   // Brain Dump (pre-filled with tasks)
//   List<String> brainDump = [
//     "Ex task",
//   ];
//   final GlobalKey _dateKey = GlobalKey();
//   final GlobalKey _braindumpFullKey = GlobalKey();
//   final GlobalKey _topPrioritiesFullKey = GlobalKey();
//   final GlobalKey _boxTimeFullKey = GlobalKey();
//   final GlobalKey _braindumpExpandedKey = GlobalKey();
//   final GlobalKey _topPrioritiesExpandedKey = GlobalKey();
//   final GlobalKey _boxTimeExpandedKey = GlobalKey();

//   List<TimeSlot> timeSlots = [];

//   void _createTuto() {
//     final target = [
//       TargetFocus(
//         identify: "date",
//         keyTarget: _dateKey,
//         alignSkip: Alignment.center,
//         shape: ShapeLightFocus.RRect,
//         radius: 8,
//         paddingFocus: 0,
//         contents: [
//           TargetContent(
//               align: ContentAlign.bottom,
//               builder: (context, controller) => Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 100.0),
//                         child: Text("Please choose the date",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleLarge
//                                 ?.copyWith(color: Colors.white)),
//                       ),
//                       const SizedBox(height: 8),
//                       ElevatedButton(
//                           onPressed: () => controller.next(),
//                           child: const Text("Next"))
//                     ],
//                   ))
//         ],
//       ),
//       TargetFocus(
//         identify: "braindump",
//         keyTarget: _braindumpFullKey,
//         alignSkip: Alignment.center,
//         shape: ShapeLightFocus.RRect,
//         radius: 8,
//         paddingFocus: 0,
//         contents: [
//           TargetContent(
//               align: ContentAlign.top,
//               builder: (context, controller) => Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text("Think about all what you can do in this day....",
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge
//                               ?.copyWith(color: Colors.white)),
//                       const SizedBox(height: 8),
//                       ElevatedButton(
//                           onPressed: () => controller.next(),
//                           child: const Text("Next"))
//                     ],
//                   ))
//         ],
//       ),
//       TargetFocus(
//         identify: "toppriorities",
//         keyTarget: _topPrioritiesFullKey,
//         alignSkip: Alignment.center,
//         shape: ShapeLightFocus.RRect,
//         radius: 8,
//         paddingFocus: 0,
//         contents: [
//           TargetContent(
//               align: ContentAlign.bottom,
//               builder: (context, controller) => Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text("What are your three top priorities?",
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge
//                               ?.copyWith(color: Colors.white)),
//                       const SizedBox(height: 8),
//                       ElevatedButton(
//                           onPressed: () => controller.next(),
//                           child: const Text("Next"))
//                     ],
//                   ))
//         ],
//       ),
//       TargetFocus(
//         identify: "boxtime",
//         keyTarget: _boxTimeFullKey,
//         alignSkip: Alignment.center,
//         shape: ShapeLightFocus.RRect,
//         radius: 8,
//         paddingFocus: 0,
//         contents: [
//           TargetContent(
//               align: ContentAlign.top,
//               builder: (context, controller) => Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text("Box your time for more efficiency",
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge
//                               ?.copyWith(color: Colors.white)),
//                       const SizedBox(height: 8),
//                       ElevatedButton(
//                           onPressed: () => controller.next(),
//                           child: const Text("Finish"))
//                     ],
//                   ))
//         ],
//       )
//     ];
//     TutorialCoachMark(
//       targets: target,
//       // textSkip: "Next",
//       colorShadow: Colors.black.withOpacity(0.8),
//       hideSkip: true,
//       alignSkip: Alignment.bottomRight,
//       // pulseEnable: false,
//       paddingFocus: 0,
//       onFinish: () {
//         debugPrint("Tutorial finished");
//       },
//       onClickTarget: (target) {
//         debugPrint('${target.identify} clicked');
//       },
//       onSkip: () {
//         debugPrint("Tutorial skipped");
//         return true;
//       },
//       // imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//     ).show(context: context);
//   }

//   Future<bool> _shouldShowTutorial() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool isFirstTime = prefs.getBool('hasShownTutorial') ?? true;
//     if (isFirstTime) {
//       await prefs.setBool('hasShownTutorial', false);
//     }
//     return isFirstTime;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );

//     // Use WidgetsBinding to ensure data is loaded after first frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _shouldShowTutorial().then((shouldShow) {
//         if (shouldShow) {
//           _createTuto();
//         }
//       });
//       _loadData();
//     });
//   }

//   @override
//   void dispose() {
//     _newTaskController.dispose();
//     _dateController.dispose();
//     _animationController.dispose();

//     // Save data when widget is disposed
//     _saveData();

//     super.dispose();
//   }

//   void copyToTopPriorities(String task) {
//     int emptyIndex = topPriorities.indexWhere((priority) => priority.isEmpty);

//     if (emptyIndex != -1) {
//       setState(() {
//         topPriorities[emptyIndex] = task;
//       });
//       _saveData();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           behavior: SnackBarBehavior.floating,
//           content:
//               Text("Top Priorities is full! Remove an item to add new ones."),
//         ),
//       );
//     }
//   }

//   void removeFromTopPriorities(int index) {
//     setState(() {
//       topPriorities[index] = "";
//     });
//     _saveData();
//   }

//   double _getFontSize(BuildContext context, double baseSize) {
//     // Scale font size based on screen width
//     double screenWidth = MediaQuery.of(context).size.width;
//     if (screenWidth < 600) {
//       return baseSize * 0.8; // 20% smaller for small screens
//     }
//     return baseSize;
//   }

//   double _getPadding(BuildContext context, double basePadding) {
//     // Scale padding based on screen width
//     double screenWidth = MediaQuery.of(context).size.width;
//     if (screenWidth < 600) {
//       return basePadding * 0.7; // 30% smaller for small screens
//     }
//     return basePadding;
//   }

//   Widget _buildTopPrioritiesSection() {
//     return Column(
//       key: selectedTable.isEmpty
//           ? _topPrioritiesFullKey
//           : _topPrioritiesExpandedKey,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Top Priorities",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         Expanded(
//           child: Card(
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: ListView.separated(
//                 itemCount: topPriorities.length,
//                 itemBuilder: (context, index) {
//                   final priority = topPriorities[index];
//                   return GestureDetector(
//                     onLongPress: () => removeFromTopPriorities(index),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       decoration: BoxDecoration(
//                         color: priority.isEmpty
//                             ? Colors.grey.shade100
//                             : Colors.blue.shade50,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: priority.isEmpty
//                               ? Colors.grey.shade300
//                               : Colors.blue.shade200,
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               priority.isEmpty ? "Empty Slot" : priority,
//                               style: TextStyle(
//                                 fontSize: _getFontSize(context, 16),
//                                 color: priority.isEmpty
//                                     ? Colors.grey.shade600
//                                     : Colors.black87,
//                               ),
//                             ),
//                           ),
//                           if (priority.isNotEmpty)
//                             IconButton(
//                               icon: const Icon(Icons.close, size: 20),
//                               onPressed: () => removeFromTopPriorities(index),
//                               color: Colors.grey.shade600,
//                             ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) => const SizedBox(height: 8),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBrainDumpSection() {
//     return Column(
//       key: selectedTable.isEmpty ? _braindumpFullKey : _braindumpExpandedKey,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Brain Dump",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         // New task input section
//         Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: selectedTable == "table2"
//                 ? Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _newTaskController,
//                           decoration: InputDecoration(
//                             hintText: "Enter new task",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed: _addNewTask,
//                         child: const Text("Add"),
//                       ),
//                     ],
//                   )
//                 : Container(
//                     height: 0,
//                   )),
//         const SizedBox(height: 12),
//         Expanded(
//           child: Card(
//             elevation: 4,
//             child: ReorderableListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: brainDump.length,
//               itemBuilder: (context, index) {
//                 final task = brainDump[index];
//                 return Padding(
//                   key: ValueKey(task),
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: topPriorities.contains(task)
//                           ? Colors.green.shade100
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: topPriorities.contains(task)
//                             ? Colors.green.shade300
//                             : Colors.grey.shade300,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade200,
//                           offset: const Offset(0, 2),
//                           blurRadius: 4,
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             onLongPress: () {
//                               copyToTopPriorities(task);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content:
//                                       Text('Added "$task" to Top Priorities'),
//                                   duration: const Duration(seconds: 2),
//                                 ),
//                               );
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 16,
//                                 horizontal: 8,
//                               ),
//                               child: Text(
//                                 task,
//                                 style: TextStyle(
//                                     fontSize: _getFontSize(context, 16)),
//                               ),
//                             ),
//                           ),
//                         ),
//                         if (selectedTable == "table2")
//                           IconButton(
//                             icon:
//                                 Icon(Icons.delete, color: Colors.red.shade700),
//                             onPressed: () => _deleteTask(index),
//                           ),
//                         const Padding(
//                             padding: EdgeInsets.only(right: 4),
//                             child:
//                                 Icon(Icons.drag_indicator, color: Colors.grey)),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               onReorder: (int oldIndex, int newIndex) {
//                 setState(() {
//                   if (newIndex > oldIndex) {
//                     newIndex -= 1;
//                   }
//                   final String task = brainDump.removeAt(oldIndex);
//                   brainDump.insert(newIndex, task);
//                 });
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _saveData() async {
//     final prefs = await SharedPreferences.getInstance();

//     // Save top priorities
//     await prefs.setStringList('topPriorities', topPriorities);

//     // Save brain dump
//     await prefs.setStringList('brainDump', brainDump);

//     // Save selected date
//     await prefs.setString('selectedDate', selectedDate.toIso8601String());

//     // Save time slots with null checks
//     final timeSlotData = timeSlots.map((slot) {
//       // Ensure we only save non-null values
//       return jsonEncode({
//         'time': slot.time,
//         'fullHour': slot.fullHour ?? '',
//         'halfHour': slot.halfHour ?? ''
//       });
//     }).toList();
//     await prefs.setStringList('timeSlots', timeSlotData);
//   }

//   Future<void> _loadData() async {
//     final prefs = await SharedPreferences.getInstance();

//     setState(() {
//       // Load top priorities with null safety
//       topPriorities = prefs.getStringList('topPriorities') ??
//           List.filled(3, "", growable: false);

//       // Load brain dump with default value
//       brainDump = prefs.getStringList('brainDump') ?? ["Ex task"];

//       // Load selected date
//       String? dateStr = prefs.getString('selectedDate');
//       if (dateStr != null) {
//         try {
//           selectedDate = DateTime.parse(dateStr);
//         } catch (e) {
//           selectedDate = DateTime.now();
//         }
//       } else {
//         selectedDate = DateTime.now();
//       }

//       // Update date controller text
//       _dateController.text =
//           "${selectedDate.day} / ${_getMonth(selectedDate.month)} / ${selectedDate.year}";

//       // Load time slots with robust parsing
//       final timeSlotData = prefs.getStringList('timeSlots');
//       if (timeSlotData != null && timeSlotData.isNotEmpty) {
//         timeSlots = timeSlotData.map((data) {
//           try {
//             print(jsonDecode(data));
//             return TimeSlot.fromJson(jsonDecode(data));
//           } catch (e) {
//             // Fallback to default if parsing fails
//             return TimeSlot(time: (timeSlots.length + 5).toString());
//           }
//         }).toList();
//       } else {
//         // Initialize default time slots if no saved data
//         timeSlots = List.generate(
//           15,
//           (index) => TimeSlot(time: (index + 5).toString()),
//         );
//       }
//     });
//   }

//   Widget _buildTimeTableSection() {
//     return Card(
//       key: selectedTable.isEmpty ? _boxTimeFullKey : _boxTimeExpandedKey,
//       elevation: 4,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Daily Schedule",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               Table(
//                 border: TableBorder.all(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 columnWidths: const {
//                   0: FlexColumnWidth(0.8),
//                   1: FlexColumnWidth(1.2),
//                   2: FlexColumnWidth(1.2),
//                 },
//                 children: [
//                   TableRow(
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade50,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         topRight: Radius.circular(8),
//                       ),
//                     ),
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(_getPadding(context, 12)),
//                         child: Center(
//                           child: Text(
//                             "Time",
//                             style:
//                                 TextStyle(fontSize: _getFontSize(context, 14)),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(_getPadding(context, 12)),
//                         child: Center(
//                           child: Text(
//                             ":00",
//                             style:
//                                 TextStyle(fontSize: _getFontSize(context, 14)),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(_getPadding(context, 12)),
//                         child: Center(
//                           child: Text(
//                             ":30",
//                             style:
//                                 TextStyle(fontSize: _getFontSize(context, 14)),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   ...List.generate(
//                     timeSlots.length,
//                     (index) {
//                       final slot = timeSlots[index];
//                       return TableRow(
//                         decoration: BoxDecoration(
//                           color:
//                               index.isEven ? Colors.grey.shade50 : Colors.white,
//                         ),
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             child: Center(
//                               child: Text(
//                                 slot.time,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: MediaQuery.of(context).size.width < 600
//                                 ? 35
//                                 : 45,
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: TextFormField(
//                               initialValue: slot.fullHour ?? '',
//                               decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding:
//                                     EdgeInsets.symmetric(vertical: 8),
//                               ),
//                               textAlign: TextAlign.center,
//                               onChanged: (value) {
//                                 setState(() {
//                                   slot.fullHour = value;
//                                 });
//                                 _saveData();
//                               },
//                             ),
//                           ),
//                           Container(
//                             height: MediaQuery.of(context).size.width < 600
//                                 ? 35
//                                 : 45,
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: TextFormField(
//                               initialValue: slot.halfHour ?? '',
//                               decoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding:
//                                     EdgeInsets.symmetric(vertical: 8),
//                               ),
//                               textAlign: TextAlign.center,
//                               onChanged: (value) {
//                                 setState(() {
//                                   slot.halfHour = value;
//                                 });
//                                 _saveData();
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _handleTableTap(String table) {
//     setState(() {
//       selectedTable = table;
//       _animationController.forward();
//     });
//   }

//   void _handleBackToMain() {
//     setState(() {
//       selectedTable = "";
//       _animationController.reverse();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("TimeBox"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.history),
//             onPressed: () {
//               // Add calendar functionality
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               // Add settings functionality
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Section with Logo and Date
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade100,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.all(12),
//                       child: const Icon(Icons.access_time, size: 32),
//                     ),
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "TimeBox",
//                           style: TextStyle(
//                             fontSize: _getFontSize(context, 24),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           "Plan your day effectively",
//                           style: TextStyle(
//                             fontSize: _getFontSize(context, 14),
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Column(
//                   key: _dateKey,
//                   children: [
//                     Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.calendar_today, size: 20),
//                             const SizedBox(width: 8),
//                             SizedBox(
//                               width: 120,
//                               child: TextFormField(
//                                 controller: _dateController,
//                                 readOnly: true,
//                                 decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "Pick a date",
//                                   contentPadding: EdgeInsets.zero,
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 onTap: () => _selectDate(context),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     if (selectedTable.isNotEmpty) ...[
//                       const SizedBox(width: 8),
//                       ElevatedButton.icon(
//                         onPressed: _handleBackToMain,
//                         icon: const Icon(Icons.arrow_back),
//                         label: const Text("Done"),
//                       ),
//                     ],
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Main Content
//             Expanded(
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 300),
//                 transitionBuilder: (Widget child, Animation<double> animation) {
//                   return FadeTransition(
//                     opacity: animation,
//                     child: child,
//                   );
//                 },
//                 child: selectedTable.isEmpty
//                     ? Row(
//                         key: const ValueKey("allTables"),
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Left Section
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   flex: 2,
//                                   child: GestureDetector(
//                                     onTap: () => _handleTableTap("table1"),
//                                     child: _buildTopPrioritiesSection(),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Expanded(
//                                   flex: 3,
//                                   child: GestureDetector(
//                                     onTap: () => _handleTableTap("table2"),
//                                     child: _buildBrainDumpSection(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           // Right Section
//                           Expanded(
//                             flex: 1,
//                             child: GestureDetector(
//                               onTap: () => _handleTableTap("table3"),
//                               child: _buildTimeTableSection(),
//                             ),
//                           ),
//                         ],
//                       )
//                     : SizedBox(
//                         key: ValueKey(selectedTable),
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: selectedTable == "table1"
//                             ? _buildTopPrioritiesSection()
//                             : selectedTable == "table2"
//                                 ? _buildBrainDumpSection()
//                                 : _buildTimeTableSection(),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
