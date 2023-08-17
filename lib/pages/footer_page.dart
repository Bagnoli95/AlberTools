import 'package:albertools/utils/my_scaffold.dart';
import 'package:flutter/material.dart';

import '../data/const_paleta.dart';
import '../data/presupuesto_spec.dart';
import '../utils/my_submit_button.dart';
import '../utils/my_textfield.dart';
import '../utils/my_title.dart';
import 'gen_pdf.dart';
import 'gen_pdf_screen.dart';

class FooterPage extends StatelessWidget {
  final PresupuestoHeader parametroHeader;
  final List<PresupuestoItem> listaProductos;
  final int totalInt;

  FooterPage({
    super.key,
    required this.parametroHeader,
    required this.listaProductos,
    required this.totalInt,
  });

  final obsDesc = TextEditingController();
  final entregaPorcentaje = TextEditingController();

  @override
  Widget build(BuildContext context) {
    obsDesc.text = "Obs: el presente presupuesto incluye materiales y mano de obra, los trabajos se realizarán según planos aprobados por la municipalidad de Asunción.";
    entregaPorcentaje.text = "70%";

    return MyScaffold(
      myBody: SingleChildScrollView(
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
                titleText: 'Pie del Presupuesto',
              ),
              const SizedBox(height: 20),

              //DescProducto
              MyTextField(controller: obsDesc, hintText: 'Observación', obscureText: false),
              const SizedBox(height: 10),

              //CantProducto
              MyTextField(controller: entregaPorcentaje, hintText: '% de Entrega', obscureText: false),

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
                    print('\n************************************************************************');
                    print('parametroHeader: \n ${parametroHeader.nroPresupuesto} - ${parametroHeader.fechaCreacion} - ${parametroHeader.nombreSolicitante} - ${parametroHeader.rucSolicitante} - ${parametroHeader.nombreCotizante}');
                    print('total: $totalInt \n');
                    print('listaProductos:');
                    for (int i = 0; i < listaProductos.length; i++) {
                      print('$i- ${listaProductos[i].descProducto}${listaProductos[i].cantProducto}${listaProductos[i].precioProducto}');
                    }
                    print('\nparametroFooter: \n ${obsDesc.text} - ${entregaPorcentaje.text}');
                    print('************************************************************************\n');

                    //Guardar el Footer
                    final parametroFooter = PresupuestoFooter(
                      descObservacion: obsDesc.text,
                      porcentajeEntrega: entregaPorcentaje.text,
                    );

                    //Enviar los datos al GenPdf
                    generateAndPreviewPDF(
                      parametroHeader: parametroHeader,
                      listaProductos: listaProductos,
                      totalInt: totalInt,
                      parametroFooter: parametroFooter,
                    );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MyPdfViewer(pdfPath: 'lib/assets/AJ_PRESUPUESTO.pdf'),
                    //   ),
                    // );
                  },
                  buttonLabel: 'Generar PDF'),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
