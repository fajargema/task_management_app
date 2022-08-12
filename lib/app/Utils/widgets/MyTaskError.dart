import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:task_management_app/app/Utils/styles/AppColors.dart';
import 'package:task_management_app/app/Utils/widgets/prosesTask.dart';

import '../../data/controller/auth_controller.dart';

class MyTask extends StatelessWidget {
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //stream user untuk ambil task list
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: authCon.streamUsers(authCon.auth.currentUser!.email!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            //mendapatkan taskId
            var taskId = (snapshot.data!.data()
                as Map<String, dynamic>)['task_id'] as List;
            return ListView.builder(
              itemCount: taskId.length,
              clipBehavior: Clip.antiAlias,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: authCon.streamTask(taskId[index]),
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      //data task
                      var dataTask = snapshot2.data!.data();
                      //data user photo
                      var dataUserList = (snapshot2.data!.data()
                          as Map<String, dynamic>)['asign_to'] as List;
                      return GestureDetector(
                        onLongPress: () {
                          Get.defaultDialog(
                            title: dataTask!['title'],
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                    onPressed: () {
                                      Get.back();
                                      authCon.titleController.text =
                                          dataTask['title'];
                                      authCon.descriptionController.text =
                                          dataTask['description'];
                                      authCon.dueDateController.text =
                                          dataTask['dueDate'];
                                      addEditTask(
                                          context: context,
                                          type: 'Update',
                                          docId: taskId[index]);
                                    },
                                    icon: const Icon(Ionicons.pencil),
                                    label: const Text('Update')),
                                TextButton.icon(
                                    onPressed: () {
                                      authCon.deleteTask(taskId[index]);
                                    },
                                    icon: const Icon(Ionicons.trash),
                                    label: const Text('Delete'))
                              ],
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(15),
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.cardBg,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Expanded(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: dataUserList.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemBuilder: (context, index2) {
                                          return StreamBuilder<
                                                  DocumentSnapshot<
                                                      Map<String, dynamic>>>(
                                              stream: authCon.streamUsers(
                                                  dataUserList[index2]),
                                              builder: (context, snapshot3) {
                                                if (snapshot3.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }
                                                //mengambil user photo
                                                var dataUserPhoto =
                                                    snapshot3.data!.data();
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.amber,
                                                    radius: 20,
                                                    foregroundImage:
                                                        NetworkImage(
                                                            dataUserPhoto![
                                                                'photo']),
                                                  ),
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 25,
                                    width: 80,
                                    color: AppColors.primaryBg,
                                    child: Center(
                                        child: Text(
                                      '${dataTask!['status']} %',
                                      style: const TextStyle(
                                        color: AppColors.primaryText,
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                height: 25,
                                width: 100,
                                color: AppColors.primaryBg,
                                child: Center(
                                    child: Text(
                                  "${dataTask['total_task_finished']}/${dataTask['total_task']}",
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                  ),
                                )),
                              ),
                              Text(
                                dataTask['title'],
                                style: const TextStyle(
                                    color: AppColors.primaryText, fontSize: 20),
                              ),
                              Text(
                                dataTask['description'],
                                style: const TextStyle(
                                    color: AppColors.primaryText, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            );
          }),
    );
  }
}
