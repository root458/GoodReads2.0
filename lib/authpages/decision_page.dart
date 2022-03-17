import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_reads_app/authpages/signin_page.dart';
import 'package:good_reads_app/counter/lister.dart';
import 'package:good_reads_app/services/_index.dart';
import 'package:good_reads_app/utils/_index.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DecisionPage extends StatelessWidget {
  const DecisionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          Hive.box<dynamic>(TrainingConfig.instance!.values.authBox)
              .listenable(),
      builder: (context, box, _) {
        if (box != null) {
          final _accToken = HiveServiceImpl().retrieveToken();

          if (_accToken != null) {
            _redirectToPage(
              context,
              const ItemListingPage(),
              routeName: TrainingRouter.homeRoute,
            );
          } else {
            _redirectToPage(
              context,
              const SignInPage(),
              routeName: TrainingRouter.authRoute,
            );
          }
        }
        return const Scaffold(
          body: Center(
            child: Text('Welcome'),
          ),
        );
      },
    );
  }

  void _redirectToPage(BuildContext context, Widget page, {String? routeName}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final _newRoute = CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => page,
        settings: RouteSettings(name: routeName),
      );

      Navigator.of(context).pushAndRemoveUntil<dynamic>(
        _newRoute,
        ModalRoute.withName(TrainingRouter.decisionRoute),
      );
    });
  }
}
