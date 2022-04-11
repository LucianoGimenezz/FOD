// 7- El encargado de ventas de un negocio de productos de limpieza desea administrar el
// stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos
// los productos que comercializa. De cada producto se maneja la siguiente información:
// código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
// Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
// realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.
// Se pide realizar un programa con opciones para:
// a.
//  Actualizar el archivo maestro con el archivo detalle, sabiendo que:
// ●
//  Ambos archivos están ordenados por código de producto.
// ●
//  Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
// archivo detalle.
// ●
//  El archivo detalle sólo contiene registros que están en el archivo maestro.
// b.
//  Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
// stock actual esté por debajo del stock mínimo permitido.
program ejercicio7;
const
  valor_alto = 9999;
type
    mProductos = record
        cod:integer;
        nombreC:String[25];
        precio:real;
        stock_actual:integer;
        stock_minimo:integer;
    end;

    dProductos = record
        cod:integer;
        cant_vendidos:integer;
    end;

    detail = file of dProductos;
    master = file of mProductos;

procedure leer(var d:detail; var reg:dProductos);
begin
  if(not Eof(d))then Read(d, reg)
  else reg.cod:= valor_alto;
end;

procedure cargarText(var m:master;var txt:Text);
var
  reg:mProductos;
begin
  while(not Eof(m))do
    begin
        Read(m, reg);
        if(reg.stock_actual < reg.stock_minimo)then WriteLn(txt, reg.cod, ' ',  reg.nombreC,' ',  reg.precio, ' ',reg.stock_actual, ' ', reg.stock_minimo);
    end;
    close(m);
    close(txt);
end;

var
   m:master;
   d:detail;
   reg:dProductos;
   regM:mProductos;
   total,codActual:integer; 
   stockmin: Text;
begin
  Assign(m, 'maestro');
  Assign(d, 'detalle');
  Reset(m);
  Reset(d);
  leer(d, reg);
  while(reg.cod <> valor_alto)do
    begin
        total:= 0;
        codActual:= reg.cod;
        while(codActual = reg.cod)do
          begin
            total:= total + reg.cant_vendidos;
            leer(d,reg);
          end;
          read(m, regM);
          while(regM.cod <> codActual)do Read(m, regM);
          regM.stock_actual:= regM.stock_actual - total;
          Seek(m, FilePos(m) - 1);
          Write(m, regM);
    end;
    Close(d);
    cargarText(m,stockmin);
end.