import 'package:flutter/material.dart';

class Nosotros extends StatelessWidget {
  const Nosotros({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nosotros'),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 196, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/lenguajes.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  heightFactor: 5,
                  child: const Text(
                    'Sobre nosotros',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Motivación',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Aunque ciertamente existen aplicaciones de este tipo, ...',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              width: 300,
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/lenguaje_señas_1.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Sobre Nosotros',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'En Mis Manos Hablarán, creemos firmemente en la inclusión ...',
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Nuestra Historia',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'La idea surgió a partir de la observación de que solo había algunas aplicaciones ...',
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Nuestros Valores',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Inclusión: Creemos en un mundo donde todas las personas ...',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 250,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 202, 255, 204),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'Contacto',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Correo Electrónico:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '2321082545@alumno.utpuebla.edu.mx',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Teléfono:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '+52 222312645',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}