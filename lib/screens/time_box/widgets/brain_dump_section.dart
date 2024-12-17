import 'package:flutter/material.dart';
import 'package:time_box/generated/l10n.dart';
import '../../../utils/helpers/helpers.dart';

class BrainDumpSection extends StatefulWidget {
  final List<String> brainDump;
  final List<String> topPriorities;
  final Function(List<String>) onUpdate;
  final Function(String) onAddToTopPriorities;
  final bool isExpanded;

  const BrainDumpSection({
    super.key,
    required this.brainDump,
    required this.topPriorities,
    required this.onUpdate,
    required this.onAddToTopPriorities,
    this.isExpanded = false,
  });

  @override
  State<BrainDumpSection> createState() => _BrainDumpSectionState();
}

class _BrainDumpSectionState extends State<BrainDumpSection> {
  final TextEditingController _newTaskController = TextEditingController();

  void _addNewTask() {
    final newTask = _newTaskController.text.trim();
    if (newTask.isNotEmpty) {
      List<String> newBrainDump = List.from(widget.brainDump)..add(newTask);
      widget.onUpdate(newBrainDump);
      _newTaskController.clear();
    }
  }

  void _deleteTask(int index) {
    List<String> newBrainDump = List.from(widget.brainDump)..removeAt(index);
    widget.onUpdate(newBrainDump);
  }

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          delegate.brain_dump,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (widget.isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newTaskController,
                    decoration: InputDecoration(
                      hintText: delegate.enter_new_task,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addNewTask,
                  child: Text(delegate.add),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        Expanded(
          child: Card(
            elevation: 4,
            child: ReorderableListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.brainDump.length,
              itemBuilder: (context, index) {
                final task = widget.brainDump[index];
                return Padding(
                  key: ValueKey(task),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.topPriorities.contains(task)
                          ? Colors.green.shade100
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: widget.topPriorities.contains(task)
                            ? Colors.green.shade300
                            : Colors.grey.shade300,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onLongPress: () =>
                                widget.onAddToTopPriorities(task),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 8,
                              ),
                              child: Text(
                                task,
                                style: TextStyle(
                                  fontSize: getFontSize(context, 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (widget.isExpanded)
                          IconButton(
                            icon:
                                Icon(Icons.delete, color: Colors.red.shade700),
                            onPressed: () => _deleteTask(index),
                          ),
                        const Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(Icons.drag_indicator, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final List<String> newBrainDump = List.from(widget.brainDump);
                final String task = newBrainDump.removeAt(oldIndex);
                newBrainDump.insert(newIndex, task);
                widget.onUpdate(newBrainDump);
              },
            ),
          ),
        ),
      ],
    );
  }
}
