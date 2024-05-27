import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/controller/selectedIndexController.dart';
import 'package:taskapp/controller/taskController.dart';
import 'package:taskapp/database/sqflite.dart';
import 'package:taskapp/model/task.dart';
import 'package:taskapp/service.dart';
import 'package:taskapp/widgets/dateCard.dart';
import 'package:taskapp/widgets/editTask.dart';
import 'package:taskapp/widgets/taskCard.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final width = Get.width;
  final height = Get.height;
  final List<DateTime> dates = List.generate(100, (index) => DateTime.now().add(Duration(days: index)));
  final SelectedIndexController selectedIndexController = Get.put(SelectedIndexController());
  final TaskController taskController = Get.put(TaskController());

  String _selectedSortOption = 'Completion';

  @override
  void initState() {
    super.initState();
    // Initialize tasks for the current date
    taskController.fetchAndSortTasks(
      selectedIndex: selectedIndexController.selectedIndex.value,
      sortByPriority: _selectedSortOption == 'Priority',
      sortByCompletion: _selectedSortOption == 'Completion',
    );
  }

  Future<void> _editTask(Task task) async {
    showDialog(
      context: context,
      builder: (context) => TaskEditScreen(
        task: task,
        onSave: () {
          taskController.fetchAndSortTasks(
            selectedIndex: selectedIndexController.selectedIndex.value,
            sortByPriority: _selectedSortOption == 'Priority',
            sortByCompletion: _selectedSortOption == 'Completion',
          );
        },
      ),
    );
  }

  void _onSortOptionChanged(String? newValue) {
    setState(() {
      _selectedSortOption = newValue!;
    });
    taskController.fetchAndSortTasks(
      selectedIndex: selectedIndexController.selectedIndex.value,
      sortByPriority: _selectedSortOption == 'Priority',
      sortByCompletion: _selectedSortOption == 'Completion',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFfcedd9), Color(0xFFfcc7d9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: width * 0.1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Hello", style: TextStyle(fontSize: 20), textAlign: TextAlign.left),
                      Text("Prabhat", style: TextStyle(fontSize: 25), textAlign: TextAlign.left),
                    ],
                  ),
                  SizedBox(width: width * 0.5),
                  const Icon(Icons.person, size: 50),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dates.asMap().entries.map<Widget>((entry) {
                    int index = entry.key;
                    DateTime date = entry.value;
                    return GestureDetector(
                      onTap: () {
                        selectedIndexController.updateSelectedIndex(index);
                        taskController.fetchAndSortTasks(
                          selectedIndex: selectedIndexController.selectedIndex.value!,
                          sortByPriority: _selectedSortOption == 'Priority',
                          sortByCompletion: _selectedSortOption == 'Completion',
                        );
                      },
                      child: Obx(() {
                        return DateCard(
                          date: date,
                          isSelected: selectedIndexController.selectedIndex.value == index,
                        );
                      }),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: _selectedSortOption,
                  onChanged: _onSortOptionChanged,
                  items: <String>['Completion', 'Priority']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: Obx(() {
                  final taskList = taskController.taskList;
                  return taskList.isEmpty
                      ? const Center(child: Text('No tasks available'))
                      : ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          NotificationService().showNotification(
                            title: 'Notification',
                            body: 'Great you started ${taskList[index].id}',
                          );
                          _editTask(taskList[index]);
                        },
                        child: TaskListTile(task: taskList[index]),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
