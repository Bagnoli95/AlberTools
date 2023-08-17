import 'dart:math';

import 'package:albertools/pages/data_page.dart';
import 'package:albertools/utils/my_submit_button.dart';
import 'package:albertools/utils/my_textfield.dart';
import 'package:albertools/utils/my_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/const_paleta.dart';
import '../data/presupuesto_spec.dart';
import '../utils/my_mini_text_field.dart';

class HeaderPage extends StatelessWidget {
  HeaderPage({super.key});

  final nroPresupuesto = TextEditingController();
  final fechaCreacion = TextEditingController();

  final nombreSolicitante = TextEditingController();
  final rucSolicitante = TextEditingController();
  final nombreCotizante = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int intRandom = random.nextInt(999) + 100;
    nroPresupuesto.text = intRandom.toString();

    final now = new DateTime.now();
    fechaCreacion.text = DateFormat('dd/MM/yyyy').format(now);

    // final String defaultCotizante = 'Alberto Morinigo González';
    nombreCotizante.text = 'Alberto Morinigo González';

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(15),
        // margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: myColorSecundary,
        ),
        child: Column(
          children: [
            const SizedBox(height: 25),

            //TITULO
            const MyTitle(
              titleText: 'Datos de la Cabecera',
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 10),

                //CantProducto
                MyMiniTextField(controller: nroPresupuesto, hintText: 'Nro Presupuesto', obscureText: false),

                const SizedBox(width: 10),

                //PrecjoProducto
                MyMiniTextField(controller: fechaCreacion, hintText: 'Fecha', obscureText: false),

                const SizedBox(width: 10),
              ],
            ),

            //DIVISOR
            const Divider(
              color: Colors.white,
              thickness: 5,
              indent: 10,
              endIndent: 10,
              height: 30,
            ),

            //Solicitante
            MyTextField(controller: nombreSolicitante, hintText: 'Solicitante', obscureText: false),
            const SizedBox(height: 10),

            //Ruc Solicitante
            MyTextField(controller: rucSolicitante, hintText: 'Ruc Solicitante', obscureText: false),
            const SizedBox(height: 10),

            //Cotizante
            MyTextField(controller: nombreCotizante, hintText: 'Cotizante', obscureText: false),

            //DIVISOR
            const Divider(
              color: Colors.white,
              thickness: 5,
              indent: 10,
              endIndent: 10,
              height: 30,
            ),

            //Botón Cargar Detalle
            MySubmitButton(
                onPress: () {
                  final headerCabecera = PresupuestoHeader(nroPresupuesto: nroPresupuesto.text, fechaCreacion: fechaCreacion.text, nombreSolicitante: nombreSolicitante.text, rucSolicitante: rucSolicitante.text, nombreCotizante: nombreCotizante.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataPage(parametroHeader: headerCabecera),
                    ),
                  );
                },
                buttonLabel: 'Cargar Detalle'),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
