program cargarArchivos;
type
    emple = record
        dep:integer;
        division:integer;
        num_emple:integer;
        categoria:integer;
        cant_hrs:integer;
    end;
    archivo = file of emple;
procedure leer(var reg:emple);
begin
  WriteLn('Ingrese el departamento');  
  readln(reg.dep);
  if(reg.dep <> -1)then
    begin
      WriteLn('Ingrese la division');  
      readln(reg.division);
      WriteLn('Ingrese el numero de empleado ');  
      readln(reg.num_emple);
      WriteLn('Ingrese la categoria');  
      readln(reg.categoria);
      WriteLn('Ingrese la cantidad de horas ');  
      readln(reg.cant_hrs);
    end;
end;
var
   maestro: archivo;
   reg:emple;
begin
  Assign(maestro, 'empleados.dat');
  Rewrite(maestro);
  leer(reg);
  while(reg.dep <> -1)do
  begin
    Write(maestro, reg);
    leer(reg);
  end;
  Close(maestro);
end.