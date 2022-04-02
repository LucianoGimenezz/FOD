//Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
//De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
//stock mínimo y precio del producto.
//Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
//debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
//maestro. La información que se recibe en los detalles es: código de producto y cantidad
//vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
//descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
//debajo del stock mínimo.
//Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
//puede venir 0 o N registros de un determinado producto.
program ejercicio3;
uses SysUtils;
const
  valor_alto = 9999;
type
    productos = record
        cod_producto:integer;
        nombre:String[25];
        descripcion:String[25];
        stock_disponible:integer;
        stock_minimo:integer;
        precio:real;
    end;

    prod_detail = record
        cod_producto:integer;
        cant_vendida:integer;
    end;

    maestro = file of productos;
    detail = file of prod_detail;

    array_detail = array [1..30] of detail;
    reg_detalle =  array [1..30] of prod_detail;

procedure asignar(var arr: array_detail);
var
  i:integer;
begin
  for i:= 1 to 30 do
  begin
    Assign(arr[i], 'datail'+ IntToStr(i));
    Reset(arr[i]);
  end;
end;

procedure leer(var detalle: detail; var prod:prod_detail);
begin
  if(not Eof(detalle))then Read(detalle, prod)
  else prod.cod_producto:= valor_alto;
end;

procedure read_reg(var arr_detail:array_detail; var arr_reg:reg_detalle);
var
  i:Integer;
begin      
  for i:= 1 to 30 do
  begin
    leer(arr_detail[i], arr_reg[i]);
  end;
end;
                                                                                        
procedure minimo(var regs:reg_detalle; var min:prod_detail; var details_arr: array_detail);
var
  i:integer;
  indice_min:integer;                                                                            
begin
  min.cod_producto:= 9999;  
  indice_min:= -1;
  for i:= 1 to 30 do
   begin
     if(regs[i].cod_producto <= min.cod_producto)then
     begin
       min.cod_producto:= regs[i].cod_producto;
       indice_min:= i;
     end;
   end;
   if(indice_min <> -1)then leer(details_arr[indice_min], regs[indice_min]);
end;

procedure closeFiles(var detalles:array_detail);
var
    i:integer;
begin
  for i:= 1 to 30 do
    Close(detalles[i]);
end;

var
    file_maestro:maestro;
    details:array_detail;
    prod:productos;
    min:prod_detail;
    registros:reg_detalle;
    pocoStock:Text;
begin
  Assign(file_maestro, 'maestro');
  Assign(pocoStock, 'pocoStock.txt');
  Rewrite(pocoStock);
  Reset(file_maestro);
  asignar(details);
  read_reg(details, registros);
  minimo(registros,min,details);
  while(min.cod_producto <> valor_alto)do
   begin
     read(file_maestro,prod);
     while(prod.cod_producto <> min.cod_producto)do read(file_maestro,prod);
     while(prod.cod_producto = min.cod_producto)do
     begin
       prod.stock_disponible:= prod.stock_disponible - min.cant_vendida;
       minimo(registros,min,details);
     end;
     Seek(file_maestro, FilePos(file_maestro) - 1);
     Write(file_maestro, prod);
     if(prod.stock_disponible < prod.stock_minimo)then Write(pocoStock, prod.nombre, prod.descripcion, prod.precio);
   end;
   Close(file_maestro);
   Close(pocoStock);
   closeFiles(details);
end.