icons:
		flutter pub run flutter_launcher_icons:main

splash:
		flutter pub run flutter_native_splash:create

gen:
		flutter packages run build_runner build --delete-conflicting-outputs

fmt:
		flutter format lib test

apk:
		flutter build apk  --flavor production --target lib/main_production.dart

sort:
		flutter pub run import_sorter:main
		
aab:
		flutter build appbundle  --flavor production --target lib/main_production.dart

sha1:
		keytool -list -v -keystore C:\Users\[USER]\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android 