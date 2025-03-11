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
                      image: AssetImage('assets/images/lenguajes.jpeg'),
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
                'Aunque ciertamente existen aplicaciones de este tipo, la cantidad de ellas es mínima en comparación con otros temas considerados más relevantes. Las aplicaciones existentes\ntienen diferencias notorias respecto a nuestra idea planteada, lo que puede ser una desventaja para aquellos que requieren aplicaciones que permitan la inclusión o el aprendizaje en\nun mismo lugar de forma dinámica. Sin embargo, esto nos brinda la oportunidad de entrar en un mercado menos saturado y ofrecer un software realmente útil, que atienda a\npersonas con capacidades diferentes, quienes a menudo son las menos favorecidas o tomadas en cuenta.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              width: 300,
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/lenguaje_señas_1.jpeg'),
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
                'En Mis Manos Hablarán, creemos firmemente en la inclusión y la accesibilidad para todos. Nuestra misión es empoderar a las personas sordas, con dificultades auditivas y con discapacidades visuales mediante la promoción del lenguaje de señas y braille. Nos esforzamos por crear un mundo donde la comunicación no tenga barreras y donde todas las personas tengan la oportunidad de participar plenamente en la sociedad.',
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
                'La idea surgió a partir de la observación de que solo había algunas aplicaciones que enseñaban estos dos lenguajes pero por separado, nosotros pensamos en integrar los dos lenguajes en una sola aplicación para que fuera más factible el aprendizaje de estos.',
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
                'Inclusión: Creemos en un mundo donde todas las personas, independientemente de sus habilidades, tengan las mismas oportunidades de comunicarse y participar.\n\nAccesibilidad: Trabajamos para eliminar las barreras de comunicación y crear entornos accesibles para todos.\n\nEmpoderamiento: Proporcionamos a las personas las herramientas y los recursos necesarios para que puedan comunicarse de manera efectiva y autónoma.\n\nEducación: Promovemos el aprendizaje continuo y ofrecemos programas educativos para fomentar el conocimiento del lenguaje de señas y braille.',
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