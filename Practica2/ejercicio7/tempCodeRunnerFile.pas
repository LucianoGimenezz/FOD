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