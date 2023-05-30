import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/config/theme/app_theme.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/screens/chat/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //MultiProvider envolvemos a toda la aplicaciCon en nuestro provider
    //con esto hacemos que todos los hijos de la aplicación tengan acceso al estado 
    return MultiProvider(
      providers: [
        //si no usamo el buildcontext, le colocamos el "_"
        //con eso le decimos que no nos interesa ese argumento
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
        title: 'Yes No App',
        debugShowCheckedModeBanner: false,
        theme:AppTheme(selectedColor:1).theme(),
        home: const ChatScreen()
      ),
    );
  }
}