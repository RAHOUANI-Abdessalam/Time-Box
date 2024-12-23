import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_box/utils/constant.dart';
import '../generated/l10n.dart';
import '../models/time_slot.dart';
import '../services/storage_service.dart';
// import '../../utils/helpers/helpers.dart';
import '../utils/helpers/tutorial_helper.dart';
import 'widgets/brain_dump_section.dart';
import 'widgets/time_table_section.dart';
import 'widgets/top_priorities_section.dart';

class TimeBoxScreen extends StatefulWidget {
  final Function(Locale) onLanguageChanged;
  const TimeBoxScreen({super.key, required this.onLanguageChanged});

  @override
  // ignore: library_private_types_in_public_api
  _TimeBoxScreenState createState() => _TimeBoxScreenState();
}

class _TimeBoxScreenState extends State<TimeBoxScreen>
    with SingleTickerProviderStateMixin {
  List<String> topPriorities =
      List.filled(TimeBoxConstants.defaultPrioritiesCount, "", growable: false);
  List<String> brainDump = ["Ex task"];
  List<TimeSlot> timeSlots = [];
  String selectedTable = "";
  DateTime selectedDate = DateTime.now();
  String currentLocale = ""; // Default locale

  late AnimationController _animationController;

  // late Animation<double> _animation;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _newTaskController = TextEditingController();

  // Tutorial keys
  final GlobalKey _dateKey = GlobalKey();
  final GlobalKey _braindumpFullKey = GlobalKey();
  final GlobalKey _topPrioritiesFullKey = GlobalKey();
  final GlobalKey _boxTimeFullKey = GlobalKey();
  final GlobalKey _braindumpExpandedKey = GlobalKey();
  final GlobalKey _topPrioritiesExpandedKey = GlobalKey();
  final GlobalKey _boxTimeExpandedKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _initializeData();
    _loadSavedLanguage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update locale and date format whenever dependencies (including Localizations) change
    final newLocale = Localizations.localeOf(context).languageCode;
    if (newLocale != currentLocale) {
      setState(() {
        currentLocale = newLocale;
        _updateDateController();
      });
    }
  }

  Future<void> _loadSavedLanguage() async {
    final savedLanguage = await StorageService.loadLanguage();
    final newLocale = Locale(savedLanguage);
    setState(() {
      currentLocale = savedLanguage;
      S.load(newLocale);
      widget.onLanguageChanged(newLocale);
      _updateDateController();
    });
  }

  void showLanguageSelectionDialog(BuildContext context) {
    final delegate = S.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(delegate.select_language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                onPressed: () {
                  _changeLanguage('en', const Locale('en', 'US'));
                },
                child: Text(delegate.English),
              ),
              MaterialButton(
                onPressed: () {
                  _changeLanguage('fr', const Locale('fr', 'FR'));
                },
                child: Text(delegate.French),
              ),
              MaterialButton(
                onPressed: () {
                  _changeLanguage('ar', const Locale('ar', 'AR'));
                },
                child: Text(delegate.Arabic),
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeLanguage(String langCode, Locale locale) {
    setState(() {
      currentLocale = langCode;
      S.load(locale);
      widget.onLanguageChanged(locale);
      _updateDateController();
    });
    StorageService.saveLanguage(langCode);
    Navigator.of(context).pop();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: TimeBoxConstants.animationDuration,
      vsync: this,
    );
    // _animation = CurvedAnimation(
    //   parent: _animationController,
    //   curve: Curves.easeInOut,
    // );
  }

  Future<void> _initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (await TutorialHelper.shouldShowTutorial()) {
        if (!mounted) return;
        TutorialHelper.showTutorial(context, _getTutorialKeys());
      }
      await _loadData();
    });
  }

  Map<String, GlobalKey> _getTutorialKeys() => {
        'date': _dateKey,
        'braindump': _braindumpFullKey,
        'topPriorities': _topPrioritiesFullKey,
        'boxTime': _boxTimeFullKey,
      };

  Future<void> _loadData() async {
    final data = await StorageService.loadData();
    setState(() {
      topPriorities = data['topPriorities'];
      brainDump = data['brainDump'];
      selectedDate = data['selectedDate'];
      timeSlots = data['timeSlots'];
      _updateDateController();
    });
  }

  void _updateDateController() {
    try {
      final formattedDate =
          DateFormat(TimeBoxConstants.defaultDateFormat, currentLocale)
              .format(selectedDate);
      _dateController.text = formattedDate;
    } catch (e) {
      // Fallback to default locale if there's an error
      final formattedDate = DateFormat(TimeBoxConstants.defaultDateFormat, 'en')
          .format(selectedDate);
      _dateController.text = formattedDate;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _updateDateController();
      });
      await _saveData();
    }
  }

  Future<void> _saveData() async {
    await StorageService.saveData(
      topPriorities: topPriorities,
      brainDump: brainDump,
      selectedDate: selectedDate,
      timeSlots: timeSlots,
    );
  }

  void _handleTableTap(String table) {
    setState(() {
      selectedTable = table;
      _animationController.forward();
    });
  }

  void _handleBackToMain() {
    setState(() {
      selectedTable = "";
      _animationController.reverse();
    });
  }

  @override
  void dispose() {
    _newTaskController.dispose();
    _dateController.dispose();
    _animationController.dispose();
    _saveData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(delegate.app_name),
        // const Text("TimeBox"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              showLanguageSelectionDialog(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TimeBoxConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(delegate),
              const SizedBox(height: 24),
              Expanded(
                child: _buildMainContent(delegate),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader([S? delegate]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(delegate),
        _buildDatePicker(delegate),
      ],
    );
  }

  Widget _buildLogo([S? delegate]) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(Icons.access_time, size: 32),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              delegate!.app_name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              delegate.app_tagline,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker([S? delegate]) {
    return Column(
      key: _dateKey,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 8),
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: delegate?.pick_a_date,
                      contentPadding: EdgeInsets.zero,
                    ),
                    textAlign: TextAlign.center,
                    onTap: () => _selectDate(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (selectedTable.isNotEmpty) ...[
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: _handleBackToMain,
            icon: const Icon(Icons.arrow_back),
            label: Text(delegate!.done),
          ),
        ],
      ],
    );
  }

  Widget _buildMainContent([S? delegate]) {
    return AnimatedSwitcher(
      duration: TimeBoxConstants.animationDuration,
      child: selectedTable.isEmpty
          ? _buildAllTables(delegate)
          : _buildSelectedTable(delegate),
    );
  }

  Widget _buildAllTables([S? delegate]) {
    return Row(
      key: const ValueKey("allTables"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => _handleTableTap("table1"),
                  child: TopPrioritiesSection(
                    key: _topPrioritiesFullKey,
                    topPriorities: topPriorities,
                    onUpdate: (newPriorities) {
                      setState(() => topPriorities = newPriorities);
                      _saveData();
                    },
                  ),
                ),
              ),
              const SizedBox(height: TimeBoxConstants.defaultPadding),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () => _handleTableTap("table2"),
                  child: BrainDumpSection(
                    key: _braindumpFullKey,
                    brainDump: brainDump,
                    topPriorities: topPriorities,
                    isExpanded: false,
                    onUpdate: (newBrainDump) {
                      setState(() => brainDump = newBrainDump);
                      _saveData();
                    },
                    onAddToTopPriorities: (task) {
                      copyToTopPriorities(task, delegate);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: TimeBoxConstants.defaultPadding),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => _handleTableTap("table3"),
            child: TimeTableSection(
              key: _boxTimeFullKey,
              timeSlots: timeSlots,
              onUpdate: (newTimeSlots) {
                setState(() => timeSlots = newTimeSlots);
                _saveData();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedTable([S? delegate]) {
    return SizedBox(
      key: ValueKey(selectedTable),
      width: double.infinity,
      height: double.infinity,
      child: _getSelectedWidget(delegate),
    );
  }

  Widget _getSelectedWidget([S? delegate]) {
    switch (selectedTable) {
      case "table1":
        return TopPrioritiesSection(
          key: _topPrioritiesExpandedKey,
          topPriorities: topPriorities,
          onUpdate: (newPriorities) {
            setState(() => topPriorities = newPriorities);
            _saveData();
          },
        );
      case "table2":
        return BrainDumpSection(
          key: _braindumpExpandedKey,
          brainDump: brainDump,
          topPriorities: topPriorities,
          isExpanded: true,
          onUpdate: (newBrainDump) {
            setState(() => brainDump = newBrainDump);
            _saveData();
          },
          onAddToTopPriorities: (task) {
            copyToTopPriorities(task, delegate);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(delegate!.task_added_to_priorities(task)),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        );
      default:
        return TimeTableSection(
          key: _boxTimeExpandedKey,
          timeSlots: timeSlots,
          onUpdate: (newTimeSlots) {
            setState(() => timeSlots = newTimeSlots);
            _saveData();
          },
        );
    }
  }

  void copyToTopPriorities(String task, [S? delegate]) {
    int emptyIndex = topPriorities.indexWhere((priority) => priority.isEmpty);

    if (emptyIndex != -1) {
      setState(() {
        topPriorities[emptyIndex] = task;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(delegate!.task_added_to_priorities(task)),
            duration: const Duration(seconds: 2),
          ),
        );
      });
      _saveData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(delegate!.priorities_full),
        ),
      );
    }
  }
}
