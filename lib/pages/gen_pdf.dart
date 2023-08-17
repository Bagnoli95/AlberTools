import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../data/presupuesto_spec.dart';

Future<void> generateAndPreviewPDF({
  required PresupuestoHeader parametroHeader,
  required List<PresupuestoItem> listaProductos,
  required int totalInt,
  required PresupuestoFooter parametroFooter,
}) async {
  final pdf = pw.Document(title: 'Presupuesto para ' + parametroHeader.nombreSolicitante);

  final ByteData bytes = await rootBundle.load('assets/header.png');
  final Uint8List list = bytes.buffer.asUint8List();

  final image = pw.MemoryImage(
    list,
  );

  rootBundle.clear();
  final ByteData bytesFooter = await rootBundle.load('assets/footer.png');
  final Uint8List listFooter = bytesFooter.buffer.asUint8List();

  final imageFooter = pw.MemoryImage(
    listFooter,
  );

  print('totalInt: ' + totalInt.toString());

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(0),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                //LA IDEA ES QUE AQUI SE CARGUE LA IMAGEN DE LA CABECERA
                pw.Image(image, fit: pw.BoxFit.contain),
                //FOOTER
                pw.Image(imageFooter, fit: pw.BoxFit.contain),
              ],
            ),
            pw.Container(
              margin: const pw.EdgeInsets.only(left: 50, right: 50, top: 110, bottom: 150),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  //ESTA ES LA LINEA DE LA FECHA
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('PRESUPUESTO',
                              style: pw.TextStyle(
                                fontSize: 24,
                                color: PdfColor.fromHex('#ff0000'),
                              )),
                          pw.Text('DE SERVICIO',
                              style: pw.TextStyle(
                                fontSize: 24,
                                color: PdfColor.fromHex('#ff0000'),
                              )),
                        ],
                      ),
                      pw.SizedBox(width: 25),
                      pw.Expanded(
                        child: pw.TableHelper.fromTextArray(
                          headerStyle: const pw.TextStyle(
                            fontSize: 16,
                          ),
                          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                          cellStyle: const pw.TextStyle(
                            fontSize: 14,
                          ),
                          context: context,
                          data: <List<String>>[
                            <String>['N° PRESUPUESTO', 'FECHA'],
                            <String>[parametroHeader.nroPresupuesto, parametroHeader.fechaCreacion],
                          ],
                        ),
                      ),
                    ],
                  ),

                  //ESTA ES LA LINEA DE LA CABECERA
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              children: [
                                pw.Text('SOLICITANTE: ',
                                    style: const pw.TextStyle(
                                      fontSize: 14,
                                    )),
                                pw.Text(parametroHeader.nombreSolicitante,
                                    style: const pw.TextStyle(
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Text('R.U.C.:              ',
                                    style: const pw.TextStyle(
                                      fontSize: 14,
                                    )),
                                pw.Text(parametroHeader.rucSolicitante,
                                    style: const pw.TextStyle(
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Text('COTIZANTE:     ',
                                    style: const pw.TextStyle(
                                      fontSize: 14,
                                    )),
                                pw.Text(parametroHeader.nombreCotizante,
                                    style: const pw.TextStyle(
                                      fontSize: 14,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  //ITEMS DE LA LISTA
                  pw.Column(
                    children: [
                      //Tabla Detalles
                      pw.TableHelper.fromTextArray(
                        headerStyle: const pw.TextStyle(
                          fontSize: 14,
                        ),
                        headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                        headers: ['DESCRIPCIÓN', 'CANT', 'PRECIO UNITARIO', 'SUB TOTAL'],
                        cellStyle: const pw.TextStyle(
                          fontSize: 14,
                        ),
                        context: context,
                        data: List<List<String>>.generate(
                          listaProductos.length,
                          (index) => [
                            listaProductos[index].descProducto,
                            listaProductos[index].cantProducto,
                            listaProductos[index].precioProducto,
                            (int.parse(listaProductos[index].precioProducto) * int.parse(listaProductos[index].cantProducto)).toString(),
                          ],
                        ),
                      ),

                      //TOTALES
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Row(
                            children: [
                              pw.Text('IVA  : ',
                                  style: const pw.TextStyle(
                                    fontSize: 14,
                                  )),
                              pw.Text('EXCENTA',
                                  style: const pw.TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                          pw.Row(
                            children: [
                              pw.Text('TOTAL: ',
                                  style: const pw.TextStyle(
                                    fontSize: 14,
                                  )),
                              pw.Text(totalInt.toString(),
                                  style: const pw.TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Paragraph(
                          text: '     ' + parametroFooter.descObservacion,
                          textAlign: pw.TextAlign.left,
                          style: const pw.TextStyle(
                            fontSize: 14,
                          )),
                      pw.Paragraph(
                          text: '     Entrega del ${parametroFooter.porcentajeEntrega}, saldo restante una vez entregado los trabajos.',
                          textAlign: pw.TextAlign.left,
                          style: const pw.TextStyle(
                            fontSize: 14,
                          )),
                    ],
                  ),

                  //FIRMA
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          //Linea de la firma
                          pw.SizedBox(
                            width: 300,
                            child: pw.Divider(
                              thickness: 1.5,
                              color: PdfColors.black,
                              height: 25,
                            ),
                          ),
                          pw.Text('Alberto Morinigo -Técnico Industrial',
                              style: const pw.TextStyle(
                                fontSize: 14,
                              )),
                          pw.Text('Patente Profesional N° 91.287',
                              style: const pw.TextStyle(
                                fontSize: 14,
                              )),
                          pw.Text('Dpto. de Operaciones',
                              style: const pw.TextStyle(
                                fontSize: 14,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
