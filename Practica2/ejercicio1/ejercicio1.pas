program ejercicio1;
const 
  valor_alto = 9999;
type
    comision = record
        cod_empleado:integer;
        nombre:String[25];
        montoC:real;
    end;
    archivo = file of comision;
procedure Leer(var file_: archivo; var com:comision);
begin
  if(not Eof(file_))then Read(file_, com)
  else com.cod_empleado:= valor_alto;
end;

procedure compactar(var archivo_old, archivo_new: archivo);
var
    com:comision;
    com_actual: comision;
    cod_actual:integer;
    total:Real;
begin
    Leer(archivo_old, com);
    while(com.cod_empleado <> valor_alto)do
    begin
        total:= 0;
        com_actual:= com;
        cod_actual:= com.cod_empleado;
        while(cod_actual = com.cod_empleado)do
        begin
          total:= total + com.montoC;
          Leer(archivo_old, com);  
        end;  
        com_actual.montoC:= total;
        Write(archivo_new, com_actual);
    end;
      Close(archivo_old);
      Close(archivo_new);
end;
var
    archivoLogico:archivo;
    archivoNuevo:archivo;
begin
  Assign(archivoLogico, 'comisiones');
  Assign(archivoNuevo, 'comisionNuevo');
  Reset(archivoLogico);
  Rewrite(archivoNuevo);
  compactar(archivoLogico, archivoNuevo);
end.