import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_2/data/models/auth_utility.dart';
import 'package:task_manager_2/ui/screens/auth/login_screen.dart';
import 'package:task_manager_2/ui/screens/others/update_profile_screen.dart';

class UserProfileAppBar extends StatefulWidget {
  final bool? isUpdateScreen;

  const UserProfileAppBar({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if ((widget.isUpdateScreen ?? false) == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpdateProfileScreen()));
          }
        },
        child: Row(
          children: [
            Visibility(
              //visible: (widget.isUpdateScreen ?? false) == false,
              child: Row(
                children: [
                  CachedNetworkImage(
                    placeholder: (_, __) => const Icon(Icons.account_circle_outlined,color: Colors.white,),
                    //imageUrl: ShowBase64Img(AuthUtility.userInfo.data!.photo ??''),
                     imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                    errorWidget: (_, __, ___) => const Icon(Icons.account_circle_outlined,color: Colors.white,),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: const Text("Log Out!",style: TextStyle(color: Colors.blue)),
                    content: const Text("Do you want to log out",style:TextStyle(color: Colors.grey)),
                    actions: [
                      ElevatedButton(onPressed: () async {
                        Navigator.pop(context);
                        await AuthUtility.clearUserInfo();
                        if (mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                                  (route) => false);
                        }
                        else {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Log out failed')));
                          }
                        }
                      }, child: const Text("Yes",style:TextStyle(color: Colors.red))),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text("No",style:TextStyle(color: Colors.green)))
                    ],
                  );
                }
            );
          },
          icon: const Icon(Icons.logout,color: Colors.white,),
        ),
      ],
    );
  }
}