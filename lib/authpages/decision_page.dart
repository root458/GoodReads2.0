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
            return const ItemListingPage();
          } else {
            return const SignInPage();
          }
        } else {
          return const SignInPage();
        }
      },
    );
  }
}
