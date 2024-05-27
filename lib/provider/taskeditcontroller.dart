import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/model/task.dart';
import 'package:taskapp/database/sqflite.dart';

class TaskEditController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  var selectedPriority = ''.obs;
  var selectedStatus = ''.obs;

  void initialize(Task task) {
    nameController = TextEditingController(text: task.name);
    descriptionController = TextEditingController(text: task.description);
    selectedPriority.value = task.priority;
    selectedStatus.value = task.status;
  }

  Future<void> saveTask(Task task, Function onSave) async {
    Task updatedTask = task.copyWith(
      name: nameController.text,
      description: descriptionController.text,
      priority: selectedPriority.value,
      status: selectedStatus.value,
    );
    await DatabaseHelper().updateTask(updatedTask);
    onSave();
    Get.back(); // Close the dialog
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
