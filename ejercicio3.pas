// 3. Realizar un programa que presente un menú con opciones para:
// a. Crear un archivo de registros no ordenados de empleados y completarlo con
// datos ingresados desde teclado. De cada empleado se registra: número de
// empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
// DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
// b. Abrir el archivo anteriormente generado y
// i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
// determinado.
// ii. Listar en pantalla los empleados de a uno por línea.
// iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
// NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una
// única vez.


program ejercicio3;
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
    emple:empleados;
    archivoFisico:String[25];
    archivoLogico:archivo;
    op:Integer;
begin
  WriteLn('Ingrese el nombre del archivo con el que desea Trabajar: ');
  ReadLn(archivoFisico);
  WriteLn('---Menu---');
  WriteLn('0. Cerrar menu');
  WriteLn('1. Crear archivo');
  WriteLn('2. Lista empleados');
  WriteLn('3. Listar empleados proximo ha jubilarse');
  WriteLn('Ingrese una opcion: ');
  ReadLn(op);
  while(op <> 0)do
  begin
    case op of
        1:begin
            assign(archivoLogico, archivoFisico);
            Rewrite(archivoLogico);
            Leer(emple);
            while((emple.apellido <> 'fin') and (emple.apellido <> 'FIN'))do
            begin
              Write(archivoLogico, emple);
              Leer(emple);
            end;  
            Close(archivoLogico);
          end;
        2:begin
            assign(archivoLogico, archivoFisico);
            Reset(archivoLogico);
            while(not Eof(archivoLogico))do
            begin
              read(archivoLogico, emple);
              WriteLn(emple.apellido,' ', emple.nombre);
            end;
            Close(archivoLogico);
          end;  
        3:begin
            WriteLn('Empleados proximos a jubilarse');  
            assign(archivoLogico, archivoFisico);
            Reset(archivoLogico);
            while(not Eof(archivoLogico))do
            begin 
              read(archivoLogico, emple);
              if(emple.edad > 70)then
                WriteLn(emple.apellido,' ', emple.nombre);
            end;
            Close(archivoLogico);
          end;  
    else
       WriteLn('Opcion Incorrecta');
    end;
      WriteLn('0. Cerrar menu');
      WriteLn('1. Crear archivo');
      WriteLn('2. Lista empleados');
      WriteLn('3. Listar empleados proximo ha jubilarse');
      WriteLn('Ingrese una opcion: ');
      ReadLn(op);
  end;  
end.