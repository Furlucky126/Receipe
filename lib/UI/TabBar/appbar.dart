import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orange.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
          .copyWith(bottom: 0),
      height: 80,
      color: Colors.orange.shade100,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.orange,
            child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/481/481490.png'),
          ),
          const SizedBox(
            width: 15,
          ),
          const Text(
            'DishDash',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: 25),
          )
        ],
      ),
    );
  }

  // @override
  // State<StatefulWidget> createState() => new ListTitleBarState(_left, _right);

  @override
// TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(80);
}

// https://cdn-icons-png.flaticon.com/512/481/481490.png
