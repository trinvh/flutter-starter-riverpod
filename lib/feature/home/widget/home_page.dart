import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inapps_picasso/shared/route/app_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('home'.tr()),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.adjust),
            onPressed: () {
              ref.read(routerProvider).go(SignInRoute.path);
              //ref.read(authNotifierProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: _widgetContent(context, ref),
    );
  }


  Widget _widgetContent(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("Hello, you're logged in"),
    );
  }
}
