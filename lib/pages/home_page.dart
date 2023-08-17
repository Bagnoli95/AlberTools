import 'package:albertools/pages/footer_page.dart';
import 'package:albertools/pages/header_page.dart';
import 'package:flutter/material.dart';

import '../data/presupuesto_spec.dart';
import '../utils/my_scaffold.dart';
import 'data_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      // body: PresupuestoPasos(), //Para el efecto swipe
      myBody: HeaderPage(),
    );
  }
}

class PresupuestoPasos extends StatelessWidget {
  const PresupuestoPasos({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      controller: controller,
      children: <Widget>[
        // HeaderPage(),
        // DataPage(
        //     parametroHeader: PresupuestoHeader(
        //         nroPresupuesto: 'swipe',
        //         fechaCreacion: 'required',
        //         nombreSolicitante: 'hola',
        //         rucSolicitante: 'JuanCarlos',
        //         nombreCotizante: 'Pepe')),
        // FooterPage(),
      ],
    );
  }
}
