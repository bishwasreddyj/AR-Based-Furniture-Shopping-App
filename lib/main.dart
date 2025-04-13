// import 'package:artest1/Screens/homepage.dart';
// import 'package:artest1/Screens/mainhomepage.dart';
import 'package:arfurnitureapp/Screens/login.dart';
import 'package:arfurnitureapp/Screens/mainhomepage.dart';
import 'package:arfurnitureapp/Screens/register.dart';
import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

List<CameraDescription> allCameras = [];
Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    allCameras = await availableCameras();
  } on CameraException catch (errorMessage) {
    print(errorMessage.description);
  }
  runApp(const MyApp());
}

// main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Furniture App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}

// class AugmentedRealityView extends StatefulWidget {
//   const AugmentedRealityView({super.key});

//   @override
//   _AugmentedRealityViewState createState() => _AugmentedRealityViewState();
// }

// class _AugmentedRealityViewState extends State<AugmentedRealityView> {
//   @override
//   Widget build(BuildContext context) {
//     return AugmentedRealityPlugin(
//       'https://www.freepnglogos.com/uploads/furniture-png/furniture-png-transparent-furniture-images-pluspng-15.png',
//     );
//   }
// }
