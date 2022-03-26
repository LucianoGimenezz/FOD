// 4. Agregar al menú del programa del ejercicio 3, opciones para:
// a. Añadir una o más empleados al final del archivo con sus datos ingresados por
// teclado.
// b. Modificar edad a una o más empleados.
// c. Exportar el contenido del archivo a un archivo de texto llamado
// “todos_empleados.txt”.
// d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
// que no tengan cargado el DNI (DNI en 00).
// NOTA: Las búsquedas deben realizarse por número de empleado


program ejercicio4;
type
    empleados = record
        num_empleado:integer;
        apellido:String[25];
        nombre:String[25];
        edad:integer;
        dni:String[9];
    end;
    archivo = file of empleados;

procedure Leer(var emple:empleados);
begin
    WriteLn('Ingrese el apellido del Empleado: ');
    ReadLn(emple.apellido);
    if((emple.apellido <> 'fin') and (emple.apellido <> 'FIN'))then
    begin
        WriteLn('Ingrese el nombre del Empleado: ');
        ReadLn(emple.nombre);
        WriteLn('Ingrese el DNI del Empleado: ');
        ReadLn(emple.dni);
        WriteLn('Ingrese la edad del Empleado: ');
        ReadLn(emple.edad);
        WriteLn('Ingrese el numero de Empleado: ');
        ReadLn(emple.num_empleado);   
    end;
end;

var
  archivoLogico:archivo;
  emple:empleados;
  op:Integer;
  numEmpleado:integer;
  flag:Boolean;
  allEmpleados:Text;
  sinDni:Text;
begin
  WriteLn('---Menu---');
  WriteLn('0. Cerrar menu');
  WriteLn('1. Agregar empleados');
  WriteLn('2. Modificar edad');
  WriteLn('3. Exportar a un archivo de texto');
  WriteLn('4. Exportar a los empleados con dni 00');

  WriteLn('Elija la opcion: '); 
  ReadLn(op); 
  while(op <> 0)do
  begin
    case op of
       1:begin
            assign(archivoLogico, 'empleados.dat');
            Reset(archivoLogico);
            seek(archivoLogico, FileSize(archivoLogico));
            Leer(emple);
            while((emple.apellido <> 'fin') and (emple.apellido <> 'FIN'))do
            begin
               Write(archivoLogico, emple);
               Leer(emple);
            end;  
            Close(archivoLogico);
         end; 
       2:begin
            assign(archivoLogico, 'empleados.dat');
            Reset(archivoLogico);     
            WriteLn('Ingrese el numero del empleado que desea modificar o -1 para terminar: ');
            ReadLn(numEmpleado);
            while(numEmpleado <> -1)do
            begin
                flag:= False;
                while((not Eof(archivoLogico)) and (not flag) ) do
                begin
                    Read(archivoLogico, emple);
                    if(emple.num_empleado = numEmpleado)then
                    begin
                      flag:= true;
                      WriteLn('Modifique la edad del empleado: ');
                      ReadLn(emple.edad);
                      Seek(archivoLogico, FilePos(archivoLogico) - 1);
                      Write(archivoLogico, emple);
                    end;  
                end;
               WriteLn('Ingrese el numero del empleado que desea modificar o -1 para terminar: ');
               ReadLn(numEmpleado);
               seek(archivoLogico, 0);
            end;  
            Close(archivoLogico);
         end; 
       3:begin
            assign(archivoLogico, 'empleados.dat');
            assign(allEmpleados, 'todos_empleados.txt');
            Reset(archivoLogico);
            Rewrite(allEmpleados);
            while(not Eof(archivoLogico))do
            begin
              Read(archivoLogico,emple);
              WriteLn(allEmpleados, emple.num_empleado, ' ', emple.apellido,' ',emple.nombre,' ', emple.edad, ' ', emple.dni, ' ');
            end;  
            Close(archivoLogico);
            Close(allEmpleados);
         end;  
       4:begin
            assign(archivoLogico, 'empleados.dat');
            assign(sinDni, 'faltaDNIEmpleado.txt');
            Reset(archivoLogico);
            Rewrite(sinDni);
            while(not Eof(archivoLogico)) do
            begin
              read(archivoLogico, emple);
              if(emple.dni = '00')then WriteLn(sinDni, emple.num_empleado, ' ', emple.apellido, ' ', emple.nombre, ' ', emple.edad, ' '); 
            end;
            Close(archivoLogico);
            Close(sinDni);
         end;  
    else
      WriteLn('Opcion incorrecta');
    end;
      WriteLn('---Menu---');
      WriteLn('0. Cerrar menu');
      WriteLn('1. Agregar empleados');
      WriteLn('2. Modificar edad');
      WriteLn('3. Exportar a un archivo de texto');
      WriteLn('4. Exportar a los empleados con dni 00');

      WriteLn('Elija la opcion: '); 
      ReadLn(op); 
  end;  
end.