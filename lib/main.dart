import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/HomePage.dart';

import 'package:notes/providers/DBprovider.dart';
import 'package:provider/provider.dart';

import 'AppRouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    ChangeNotifierProvider<DBprovider>(
      create: (context) => DBprovider(),
      child: EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path: 'assets/lans', // <-- change the path of the translation files
          fallbackLocale: Locale('en'),
          child: MainRun()),
    ),
  );
}

class MainRun extends StatelessWidget {
  MainRun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      navigatorKey: AppRouter.navKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: HomePageStateful(),
    ));
  }
}
