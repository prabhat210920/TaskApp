import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/controller/taskController.dart';
import 'package:taskapp/model/task.dart';
import 'package:taskapp/database/sqflite.dart';

class TaskEditScreen extends StatefulWidget {
  final Task task;
  final Function onSave;
  const TaskEditScreen({required this.task, required this.onSave, Key? key}) : super(key: key);

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late String _selectedPriority;
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.task.name);
    _descriptionController = TextEditingController(text: widget.task.description);
    _selectedPriority = widget.task.priority;
    _selectedStatus = widget.task.status;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    Task updatedTask = widget.task.copyWith(
      name: _nameController.text,
      description: _descriptionController.text,
      priority: _selectedPriority,
      status: _selectedStatus,
    );

    // Call the updateSingleTask method from TaskController
    await Get.find<TaskController>().updateTask(updatedTask);

    widget.onSave();
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Task Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              decoration: const InputDecoration(labelText: 'Priority'),
              items: ['High', 'Mid', 'Low']
                  .map((priority) => DropdownMenuItem<String>(
                value: priority,
                child: Text(priority),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(labelText: 'Status'),
              items: ['Pending', 'Done']
                  .map((status) => DropdownMenuItem<String>(
                value: status,
                child: Text(status),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
