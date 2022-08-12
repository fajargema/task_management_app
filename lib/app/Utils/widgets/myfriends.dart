import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:task_management_app/app/Utils/styles/AppColors.dart';
import 'package:task_management_app/app/routes/app_pages.dart';

class MyFriend extends StatelessWidget {
  const MyFriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'My Friends',
                    style:
                        TextStyle(color: AppColors.primaryText, fontSize: 25),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.FRIENDS),
                    child: const Text(
                      'more',
                      style:
                          TextStyle(color: AppColors.primaryText, fontSize: 20),
                    ),
                  ),
                  const Icon(
                    Ionicons.chevron_forward,
                    color: AppColors.primaryText,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.isPhone ? 2 : 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 40),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: const Image(
                                image: NetworkImage(
                                    'https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2022/06/26/4162943265.jpg',
                                    scale: 3)),
                          ),
                          const Text(
                            'Hapid Nurul Ojan',
                            style: TextStyle(
                              color: AppColors.primaryText,
                            ),
                          ),
                        ],
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
