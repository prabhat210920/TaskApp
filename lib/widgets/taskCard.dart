import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/controller/taskController.dart';
import 'package:taskapp/model/task.dart';
import 'package:taskapp/service.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  final bool isdone = false;
  TaskListTile({Key? key, required this.task}) : super(key: key);

  Future<void> _deleteTask(Task task) async {
    await Get.find<TaskController>().deleteTask(task.id!);
  }

  // Future<void> _toggleTaskStatus(Task task) async {
  //   task.status = task.status == "Done" ? "Pending" : "Done";
  //   await Get.find<TaskController>().updateTask(task);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        color: task.status == "Done" ? Colors.green[100] : Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                task.status == "Done" ? Icons.check_circle : Icons.assignment,
                color: task.status == "Done" ? Colors.green : Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Category: ${task.category}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Priority: ${task.priority}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Start Date: ${task.startDate}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "End Date: ${task.endDate}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (task.status != "Done") // Show the status change icon only if the task status is not "Done"
                IconButton(
                  onPressed: () async {
                    NotificationService().showNotification(
                      title: 'Notification',
                      body: 'Congratulation you have completed ${task.name}',
                    );
                    await Get.find<TaskController>().updateTask(Task(name: task.name, id: task.id, category: task.category, startDate: task.startDate, endDate: task.endDate, description: task.description, priority: task.priority, status: "Done"));
                  },
                  icon: const Icon(Icons.mark_chat_read_outlined, size: 32,),
                ),
              IconButton(
                onPressed: () async {
                  await _deleteTask(task);
                },
                icon: const Icon(Icons.delete, size: 32,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
