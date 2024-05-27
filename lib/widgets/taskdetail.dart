// import 'package:flutter/material.dart';
//
// class TaskCard extends StatelessWidget {
//   final String taskName;
//   final String deadline;
//   final String taskType;
//   final String priority;
//   final VoidCallback onTap;
//   final String imageUrl;
//
//   const TaskCard({
//     Key? key,
//     required this.taskName,
//     required this.deadline,
//     required this.taskType,
//     required this.onTap,
//     required this.priority,
//     required this.imageUrl,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: Image.asset(
//           'asset/todoapp.jpeg',
//           width: 70,
//           height: 150,
//           fit: BoxFit.cover,
//         ),
//         title: Text(
//           taskName,
//           style: const TextStyle(fontWeight: FontWeight.bold,),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Deadline: $deadline'),
//             Text('Type: $taskType'),
//             Text('Priority: $priority'),  // Added priority display
//           ],
//         ),
//         trailing: GestureDetector(
//           onTap: onTap,
//           child: const Icon(Icons.more_vert),
//         ),
//       ),
//     );
//   }
// }
