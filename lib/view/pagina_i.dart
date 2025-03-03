import 'package:flutter/material.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis manos hablarán', style: TextStyle(color: Color.fromARGB(255, 219, 219, 219)),),
        backgroundColor: const Color.fromARGB(255, 54, 54, 54),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 255, 195, 222),
        child: ListView(
          padding: EdgeInsets.zero, 
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 151, 172),
              ),
              child: Center( // Usamos Center para centrar el texto
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Color.fromARGB(186, 255, 255, 255),
                    fontSize: 50,
                    letterSpacing: 6,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.g_translate),
              title: const Text('Lenguajes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline_outlined),
              title: const Text('Lecciones tomadas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/lecciones');
              },
            ),
            ListTile(
              leading: const Icon(Icons.assessment),
              title: const Text('Desempeño'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/desempeno');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/perfil');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre nosotros'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/nosotros');
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 122, 188, 241),
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '¿Qué deseas aprender hoy?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 6, 8, 40)) ,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero, // Evita que el padding afecte la forma del botón
                            backgroundColor: Colors.transparent, // Fondo transparente
                            shadowColor: Colors.transparent, // Sin sombra
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/lenguaS');
                          },
                          child: Ink(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle, // Mantiene la forma circular
                              image: DecorationImage(
                                image: AssetImage('assets/images/senas.png'),
                                fit: BoxFit.cover, 
                              ),
                            ),
                            child: Container(
                              width: 180,
                              height: 180, 
                              alignment: Alignment.center,
                              child: const Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text('Lenguaje de señas mexicana',style: TextStyle(fontSize: 22),),
                      ],
                    ),
                    const SizedBox(height: 70),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent, 
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/Braille');
                          },
                          child: Ink(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/manos.png'),
                                fit: BoxFit.cover, 
                              ),
                            ),
                            child: Container(
                              width: 180, 
                              height: 180,
                              alignment: Alignment.center,
                              child: const Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text('Braille', style: TextStyle(fontSize: 22),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}