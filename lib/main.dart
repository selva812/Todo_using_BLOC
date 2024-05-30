import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_using_bloc/screens/tab_screen.dart';
import 'package:todo_using_bloc/service/app_router.dart';
import 'package:todo_using_bloc/service/app_theme.dart';

import 'blocs/bloc_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp(
    approuter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.approuter,
  }) : super(key: key);
  final AppRouter approuter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Todo using Bloc',
            debugShowCheckedModeBanner: false,
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: approuter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
