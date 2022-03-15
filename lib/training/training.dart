import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_reads_app/l10n/l10n.dart';
import 'package:good_reads_app/utils/_index.dart';

class Training extends StatelessWidget {
  const Training({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        color: TrainingTheme.primaryColor,
        title: 'Training',
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: widget!,
          );
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: TrainingTheme.primaryColor),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: TrainingTheme.primaryColor,
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        // initialRoute: TrainingRouter.decisionRoute,
        onGenerateRoute: TrainingRouter.generateRoute,
      ),
    );
  }
}
