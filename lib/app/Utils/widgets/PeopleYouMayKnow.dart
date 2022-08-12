import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../data/controller/auth_controller.dart';

class PeopleYouMayKnow extends StatelessWidget {
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: authCon.getPeople(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            var data = snapshot.data!.docs;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              clipBehavior: Clip.antiAlias,
              itemCount: data.length,
              itemBuilder: (context, index) {
                var hasil = data[index].data();
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(hasil['photo']),
                        height: 200,
                        width: 170,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 7,
                        left: 30,
                        child: Text(
                          hasil['name'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        height: 36,
                        width: 36,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () => authCon.addFriends(hasil['email']),
                          child: const Icon(
                            Ionicons.add_circle_outline,
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              },
            );
          }),
    );
  }
}
