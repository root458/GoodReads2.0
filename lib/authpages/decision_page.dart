import 'package:flutter/material.dart';
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
              routeName: TrainingRouter.homeRoute,
            );
          } else {
            _redirectToPage(
              context,
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

  void _redirectToPage(BuildContext context, {required String routeName}) {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        Navigator.popAndPushNamed(
          context,
          routeName,
        );
      },
    );
  }
}
