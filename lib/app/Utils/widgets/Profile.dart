import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/app/Utils/styles/AppColors.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: !context.isPhone
          ? Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: ClipRRect(
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 150,
                      foregroundImage:
                          NetworkImage('assets/Images/foto.png'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Fajar Gema Ramadhan',
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 40),
                      ),
                      Text(
                        'fajar.ramadhan.ti.20@cic.ac.id',
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 16),
                      ),
                      Text(
                        'TI-SE 1/4',
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ClipRRect(
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 100,
                      foregroundImage:
                          NetworkImage('assets/Images/foto.png'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Fajar Gema',
                    style:
                        TextStyle(color: AppColors.primaryText, fontSize: 20),
                  ),
                  Text(
                    'fgemar72@gmail.com',
                    style:
                        TextStyle(color: AppColors.primaryText, fontSize: 16),
                  ),
                  Text(
                    'TI-SE 1/4',
                    style:
                        TextStyle(color: AppColors.primaryText, fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
