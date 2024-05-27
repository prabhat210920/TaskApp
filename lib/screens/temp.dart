import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/model/task.dart';
import 'package:taskapp/widgets/dateCard.dart';
import 'package:taskapp/widgets/editTask.dart';
import 'package:taskapp/widgets/taskCard.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    final List<DateTime> dates = List.generate(100, (index) => DateTime.now().add(Duration(days: index)));
    final SelectedIndexController selectedIndexController = Get.put(SelectedIndexController());
    final TaskController taskController = Get.put(TaskController());

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
              Expanded(
                child: Obx(() {
                  final taskList = taskController.taskList;
                  return taskList.isEmpty
                      ? const Center(child: Text('No tasks available'))
                      : ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _editTask(context, taskList[index], taskController);
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

  void _editTask(BuildContext context, Task task, TaskController taskController) {
    showDialog(
      context: context,
      builder: (context) => TaskEditScreen(
        task: task,
        onSave: () {
          taskController.updateTask(task);
        },
      ),
    );
  }
}
