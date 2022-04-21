// 2. Definir un programa que genere un archivo con registros de longitud fija conteniendo
// información de asistentes a un congreso a partir de la información obtenida por
// teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
// nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
// archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
// asistente inferior a 1000.
// Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
// String a su elección. Ejemplo: ‘@Saldaño’.
program ejercicio2;
type
    asistente = record
        nro_asistente:integer;
        apellido_y_nombre:String[60];
        email:String[25];
        telefono:integer;
        DNI:String[20];
    end;

    archivo = file of asistente;
procedure leer(var reg:asistente);
begin
  writeln('Ingrese el numero de asistente');
  ReadLn(reg.nro_asistente);
  if(reg.nro_asistente <> -1)then
    begin
        writeln('Ingrese el nombre y apellido del asistente');
        ReadLn(reg.apellido_y_nombre);
        writeln('Ingrese el email');
        ReadLn(reg.email);
        writeln('Ingrese el numero de telefono');
        ReadLn(reg.telefono);
        writeln('Ingrese el Dni');
        ReadLn(reg.DNI);
    end;
end;

procedure cargarArchivo(var f:archivo);
var
  reg:asistente;
begin
  leer(reg);
  while(reg.nro_asistente <> -1)do
    begin
        Write(f,reg);
        leer(reg);
    end;
    close(f);
end;

procedure borradoLogico(var f:archivo);
var
  reg:asistente;  
begin
  while(not Eof(f))do
    begin
       Read(f, reg);
       if(reg.nro_asistente < 1000)then 
       begin
         reg.apellido_y_nombre:= '#'+reg.apellido_y_nombre;
         Seek(f, FilePos(f) - 1);
         Write(f, reg);
       end; 
    end;
    close(f);
end;

var
    file_:archivo;
begin
  Assign(file_, 'asistentes.dat');
  Rewrite(file_);
  cargarArchivo(file_);
  Reset(file_);
  borradoLogico(file_);
end.