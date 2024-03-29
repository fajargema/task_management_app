import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../data/controller/auth_controller.dart';
import '../../routes/app_pages.dart';
import '../styles/AppColors.dart';

class MyFriend extends StatelessWidget {
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    'My Friends',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 30,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (() => Get.toNamed(Routes.FRIENDS)),
                    child: const Text(
                      'More',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Icon(
                    Ionicons.chevron_forward,
                    color: AppColors.primaryText,
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 200,
                    child: StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        stream: authCon.streamFriends(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          var myFriends = (snapshot.data!.data()
                              as Map<String, dynamic>)['emailFriends'] as List;
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: myFriends.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: context.isPhone ? 2 : 5,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 30,
                            ),
                            itemBuilder: (context, index) {
                              return StreamBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                  stream: authCon.streamUsers(myFriends[index]),
                                  builder: (context, snapshot2) {
                                    if (snapshot2.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    var data = snapshot2.data!.data();
                                    return Column(children: [
                                      CircleAvatar(
                                        maxRadius: 60,
                                        foregroundImage:
                                            NetworkImage(data!['photo']),
                                      ),
                                      Text(
                                        data['name'],
                                        style: const TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 18),
                                      ),
                                    ]);
                                  });
                            },
                          );
                        }),
                  ))
            ])),
      ),
    );
  }
}
