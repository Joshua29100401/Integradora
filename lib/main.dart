import 'package:integradora/view/views.dart';
import 'package:integradora/view/mi_perfil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://azjgiodjzrnvbegmfszs.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF6amdpb2RqenJudmJlZ21mc3pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4MTAwMTUsImV4cCI6MjA1NTM4NjAxNX0.Y8wfEVyzLwE6vf8I-AvsBk4cTNHP8mAJ1WSUYq2P8bM',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mis manos hablarán',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 24, 188, 229),
              ),
            ),
            home: provider.isLoggedIn ? const PaginaInicio() : const LoginPage(),
            routes: {
              '/home': (context) => const PaginaInicio(),
              '/perfil': (context) => const MiPerfil(),
              '/lecciones': (context) => const Lecciones(),
              '/desempeno': (context) => const Desempeno(),
              '/nosotros': (context) => const Nosotros(),
              '/lenguaS': (context) => const LenguaS(),
              '/Braille': (context) => const Braille(),
              '/Registro': (context) => SignupPage(),
              '/inicioS': (context) => const LoginPage(),
            },
          );
        },
      ),
    );
  }
}