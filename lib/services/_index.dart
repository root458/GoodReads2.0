library training_services;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_reads_app/models/_index.dart';
import 'package:good_reads_app/utils/_index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'auth_service.dart';
part 'book_api_service.dart';
part 'hive_service.dart';

NetworkUtil _networkUtil = NetworkUtil();
