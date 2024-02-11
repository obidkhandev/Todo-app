import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/ui/home/ui/home_page.dart';
import 'package:todo_app/ui/sign/ui/login_page.dart';
import 'package:todo_app/utils/tools/file_importers.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.green,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.active) {
            bool isRegistered = FirebaseAuth.instance.currentUser != null;
            return isRegistered ? const HomePage() : const LoginPage();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
