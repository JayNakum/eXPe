import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:expe/providers/expe.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Expe _expe = Provider.of<Expe>(
      context,
      listen: false,
    );
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Expe',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text(
                    'This will delete all the expenses. It cannot be reversed.',
                  ),
                  actions: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        _expe.deleteAll();
                        Navigator.of(context).pop();
                      },
                      child: Text('Proceed'),
                    ),
                  ],
                ),
              );
            },
            leading: const Icon(Icons.delete_forever_rounded),
            title: const Text('Delete All Expenses'),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.contact_support_rounded),
            title: const Text('Contact Me'),
            onTap: () {
              const _website = 'https://JayNakum.github.io/';
              launch(_website);
            },
          )
        ],
      ),
    );
  }
}
