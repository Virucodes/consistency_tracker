import 'package:consistency_tracker/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.brightness_6,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            title: Text(
              'Theme Mode',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            trailing: CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggletheme(),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          Divider(
            thickness: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

