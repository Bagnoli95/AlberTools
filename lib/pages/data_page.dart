import 'package:albertools/pages/footer_page.dart';
import 'package:albertools/utils/my_subtitle.dart';
import 'package:flutter/material.dart';

import '../data/const_paleta.dart';
import '../data/presupuesto_spec.dart';
import '../utils/my_mini_text_field.dart';
import '../utils/my_scaffold.dart';
import '../utils/my_submit_button.dart';
import '../utils/my_textfield_focus.dart';
import '../utils/my_title.dart';

class DataPage extends StatefulWidget {
  final PresupuestoHeader parametroHeader;

  const DataPage({super.key, required this.parametroHeader});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<PresupuestoItem> listaProductos = [];
  late FocusNode myFocusNode;
  String totalPreview = 'Total Cargado: ';
  int totalPreviewInt = 0;
  int totalPreviewIntAux = 0;

  @override
  initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  _onPressed(String desc, String cant, String precio) {
    setState(() {
      final itemList = PresupuestoItem(
        descProducto: desc,
        cantProducto: cant,
        precioProducto: precio,
      );
      //Se agrega a la lista
      listaProductos.add(itemList);

      //Se suma el preview del total
      totalPreviewIntAux = int.parse(cant) * int.parse(precio);
      totalPreviewInt += totalPreviewIntAux;
      totalPreview = 'Total Cargado: ' + totalPreviewInt.toString();

      //Se vacia los campos de arriba
      descProducto.clear();
      cantProducto.clear();
      precioUniProducto.clear();

      //Se setea el focus en descProducto
      myFocusNode.requestFocus();
    });
  }

  _listViewBuilder() {
    return ListView.builder(
      itemCount: listaProductos.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(listaProductos[index].descProducto),
          onDismissed: (direction) {
            var delete = listaProductos[index].descProducto;
            totalPreviewIntAux = int.parse(listaProductos[index].cantProducto) * int.parse(listaProductos[index].precioProducto);
            totalPreviewInt -= totalPreviewIntAux;
            totalPreview = 'Total Cargado: ' + totalPreviewInt.toString();
            setState(() {
              listaProductos.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$delete eliminado')));
          },
          // Show a red background as the item is swiped away.
          background: Container(color: Colors.red),
          child: ListTile(
            title: Text(
              listaProductos[index].descProducto,
              style: TextStyle(color: myColorQuaternary),
            ),
            subtitle: Text(
              'Cant: ${listaProductos[index].cantProducto} - Precio Unitario: ${listaProductos[index].precioProducto}',
              style: TextStyle(color: myColorQuaternary),
            ),
            // leading: Icon(Icons.delete),
            trailing: Icon(Icons.delete),
          ),
        );
      },
    );
  }

  final descProducto = TextEditingController();
  final cantProducto = TextEditingController();
  final precioUniProducto = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                titleText: 'Detalle del Presupuesto',
              ),
              const SizedBox(height: 20),

              //DescProducto
              MyTextFieldFocus(
                myFocusNode: myFocusNode,
                controller: descProducto,
                hintText: 'Descripción del Producto',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 10),

                  //CantProducto
                  MyMiniTextField(controller: cantProducto, hintText: 'Cantidad', obscureText: false),

                  const SizedBox(width: 10),

                  //PrecjoProducto
                  MyMiniTextField(controller: precioUniProducto, hintText: 'Precio Unitario', obscureText: false),

                  const SizedBox(width: 10),
                ],
              ),

              const SizedBox(height: 10),

              //Botón Cargar Detalle
              MySubmitButton(
                  onPress: () {
                    _onPressed(descProducto.text, cantProducto.text, precioUniProducto.text);
                  },
                  buttonLabel: 'Agregar'),

              //DIVISOR
              const Divider(
                color: Colors.white,
                thickness: 5,
                indent: 10,
                endIndent: 10,
                height: 30,
              ),

              //LISTA
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: myColorPrimary,
                ),
                child: Column(
                  children: [
                    //SUBTITULO
                    const SizedBox(height: 5),
                    MySubTitle(titleText: 'Productos Cargados'),
                    const SizedBox(height: 5),

                    //Divisor
                    const Divider(
                      color: Colors.white,
                      thickness: 1.5,
                      indent: 10,
                      endIndent: 10,
                      height: 10,
                    ),

                    //LISTA
                    SizedBox(
                      height: 250,
                      child: _listViewBuilder(),
                    ),

                    //Divisor
                    const Divider(
                      color: Colors.white,
                      thickness: 1.5,
                      indent: 10,
                      endIndent: 10,
                      height: 10,
                    ),

                    //SUBTITULO
                    const SizedBox(height: 5),
                    MySubTitle(titleText: totalPreview),
                    const SizedBox(height: 5),
                  ],
                ),
              ),

              //DIVISOR
              const Divider(
                color: Colors.white,
                thickness: 5,
                indent: 10,
                endIndent: 10,
                height: 30,
              ),

              //Botón Sgte
              MySubmitButton(
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FooterPage(
                          parametroHeader: widget.parametroHeader,
                          listaProductos: listaProductos,
                          totalInt: totalPreviewInt,
                        ),
                      ),
                    );
                  },
                  buttonLabel: 'Siguiente'),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
