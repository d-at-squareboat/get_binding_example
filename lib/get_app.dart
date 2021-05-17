import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Routes
abstract class Routes {
  static const HOME = '/home';
  static const DETAILS = '/details';
}

// Pages
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.DETAILS,
      page: () => DetailsPage(),
      binding: DetailsPageBinding(),
    ),
  ];
}

// App
class GetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Get Binding Example',
      initialRoute: Routes.HOME,
      getPages: AppPages.pages,
      initialBinding: HomePageBinding(),
    );
  }
}

/// Home

// Home Binding
class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController());
  }
}

// Home Controller
class HomePageController extends GetxController {
  final _name = ''.obs;
  String get name => this._name.value;
  set name(String value) => this._name.value = value;

  void tapMePressed() {
    // Get.put(DetailsPageController(name));
    // Get.to(DetailsPage());
    Get.toNamed(Routes.DETAILS, arguments: name);
  }
}

// Home Page
class HomePage extends StatelessWidget {
  final controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Binding Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(controller.name, style: Get.textTheme.headline6)),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => controller.name = value,
              decoration: InputDecoration(hintText: 'Type something here...'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Tap Me!'),
              onPressed: controller.tapMePressed,
            ),
          ],
        ),
      ),
    );
  }
}

/// Details

// Details Controller
class DetailsPageController extends GetxController {
  final String name;

  DetailsPageController(this.name);
}

// Details Binding
class DetailsPageBinding implements Bindings {
  @override
  void dependencies() {
    final name = Get.arguments;
    Get.put(DetailsPageController(name));
  }
}

// Details Page
class DetailsPage extends StatelessWidget {
  final controller = Get.find<DetailsPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Center(
        child: Text(controller.name),
      ),
    );
  }
}
