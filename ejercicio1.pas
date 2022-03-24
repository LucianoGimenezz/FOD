program act1;
type
  archivo = file of integer;
var 
  archivo_logico: archivo;
  archivo_fisico: String[20];
  num: integer;
begin
  writeln('Ingrese el nombre del archivo: ');
  readln(archivo_fisico);
  assign(archivo_logico,archivo_fisico);
  rewrite(archivo_logico);
  writeln('Ingrese un numero entero: ');
  readln(num);
  while(num <> 30000)do
  begin
    write(archivo_logico, num);
    writeln('Ingrese un numero entero: ');
    readln(num);  
  end;
  close(archivo_logico);
end.