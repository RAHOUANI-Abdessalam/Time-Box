import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialHelper {
  static Future<bool> shouldShowTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('hasShownTutorial') ?? true;
    if (isFirstTime) {
      await prefs.setBool('hasShownTutorial', false);
    }
    return isFirstTime;
  }

  static void showTutorial(BuildContext context, Map<String, GlobalKey> keys) {
    final targets = [
      _createTarget(
        "date",
        keys['date']!,
        "Please choose the date",
        ContentAlign.bottom,
      ),
      _createTarget(
        "braindump",
        keys['braindump']!,
        "Think about all what you can do in this day....",
        ContentAlign.top,
      ),
      _createTarget(
        "toppriorities",
        keys['topPriorities']!,
        "What are your three top priorities?",
        ContentAlign.bottom,
      ),
      _createTarget(
        "boxtime",
        keys['boxTime']!,
        "Box your time for more efficiency",
        ContentAlign.top,
        isLast: true,
      ),
    ];

    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black.withOpacity(0.8),
      hideSkip: true,
      alignSkip: Alignment.bottomRight,
      paddingFocus: 0,
      onFinish: () => debugPrint("Tutorial finished"),
      onClickTarget: (target) => debugPrint('${target.identify} clicked'),
      onSkip: () {
        debugPrint("Tutorial skipped");
        return true;
      },
    ).show(context: context);
  }

  static TargetFocus _createTarget(
    String identify,
    GlobalKey key,
    String text,
    ContentAlign align, {
    bool isLast = false,
  }) {
    return TargetFocus(
      identify: identify,
      keyTarget: key,
      alignSkip: Alignment.center,
      shape: ShapeLightFocus.RRect,
      radius: 8,
      paddingFocus: 0,
      contents: [
        TargetContent(
          align: align,
          builder: (context, controller) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (isLast) {
                    controller.next();
                  } else {
                    controller.next();
                  }
                },
                child: Text(isLast ? "Finish" : "Next"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
