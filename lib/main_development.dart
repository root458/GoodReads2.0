// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:good_reads_app/app/app.dart';
import 'package:good_reads_app/services/_index.dart';
import 'package:good_reads_app/training/training_bloc_observer.dart';
import 'package:good_reads_app/utils/_index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TrainingConfig(
    values: TrainingValues(
      baseDomain: 'https://jsonkeeper.com',
      authBox: 'training_development',
    ),
  );

  await HiveServiceImpl().initBoxes();
  await Firebase.initializeApp();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          MultiBlocProvider(
            providers: Singletons.registerCubits(),
            child: const App(),
          ),
        ),
        blocObserver: TrainingBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
