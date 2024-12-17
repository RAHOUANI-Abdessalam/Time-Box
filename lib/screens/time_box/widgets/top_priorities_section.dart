import 'package:flutter/material.dart';
import 'package:time_box/generated/l10n.dart';
import 'package:time_box/utils/helpers/helpers.dart';

class TopPrioritiesSection extends StatelessWidget {
  final List<String> topPriorities;
  final Function(List<String>) onUpdate;

  const TopPrioritiesSection({
    super.key,
    required this.topPriorities,
    required this.onUpdate,
  });

  void removeFromTopPriorities(int index) {
    List<String> newPriorities = List.from(topPriorities);
    newPriorities[index] = "";
    onUpdate(newPriorities);
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          delegate.top_priorities,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemCount: topPriorities.length,
                itemBuilder: (context, index) {
                  final priority = topPriorities[index];
                  return GestureDetector(
                    onLongPress: () => removeFromTopPriorities(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: priority.isEmpty
                            ? Colors.grey.shade100
                            : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: priority.isEmpty
                              ? Colors.grey.shade300
                              : Colors.blue.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              priority.isEmpty ? delegate.empty_slot : priority,
                              style: TextStyle(
                                fontSize: getFontSize(context, 16),
                                color: priority.isEmpty
                                    ? Colors.grey.shade600
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          if (priority.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () => removeFromTopPriorities(index),
                              color: Colors.grey.shade600,
                            ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
