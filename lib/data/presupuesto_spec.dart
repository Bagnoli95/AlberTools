class PresupuestoHeader {
  //Cabecera
  String nroPresupuesto;
  String fechaCreacion;

  String nombreSolicitante;
  String rucSolicitante;
  String nombreCotizante;

  PresupuestoHeader({
    required this.fechaCreacion,
    required this.nroPresupuesto,
    required this.nombreSolicitante,
    required this.rucSolicitante,
    required this.nombreCotizante,
  });
}

class PresupuestoItem {
  //Cabecera
  String descProducto;
  String cantProducto;
  String precioProducto;

  PresupuestoItem({
    required this.descProducto,
    required this.cantProducto,
    required this.precioProducto,
  });
}

class PresupuestoDataList {
  List<PresupuestoItem> listaProductos;

  PresupuestoDataList({required this.listaProductos});
}

class PresupuestoFooter {
  //Cabecera
  String descObservacion;

  String porcentajeEntrega;

  PresupuestoFooter({
    required this.descObservacion,
    required this.porcentajeEntrega,
  });
}
