import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_post/home/home_page.dart';
import 'package:user_post/home/model/user_model.dart';
import 'package:user_post/utils/routes.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: MyRoutes.routes,
      initialRoute: 'home',
    );
  }
}

 init() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = await getApplicationDocumentsDirectory();
  Hive
    ..init(path.path)
    ..registerAdapter(UserAdapter())
      ..registerAdapter(AddressAdapter())
        ..registerAdapter(GeoAdapter())
          ..registerAdapter(CompanyAdapter());
  await Hive.openBox('usersBox');
}
