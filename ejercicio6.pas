program ejercicio6;
type
    celulares = record
        cod_celular:integer;
        nombre:String[20];
        descripcion:String[25];
        marca:String[20];
        precio:real;
        stock_disponible:integer;
        stock_minimo:integer;
    end;
    archivo = file of celulares;   
procedure Leer(var celu:celulares);
begin
    WriteLn('Ingrese el codigo de celular: ');
    ReadLn(celu.cod_celular);
    WriteLn('Ingrese el nombre del celular: ');
    ReadLn(celu.nombre);
    WriteLn('Ingrese el precio del celular: ');
    ReadLn(celu.precio);
    WriteLn('Ingrese la marca del celular: ');
    ReadLn(celu.marca);
    WriteLn('Ingrese la descripcion del celular: ');
    ReadLn(celu.descripcion);
    WriteLn('Ingrese el stock disponible del celular: ');
    ReadLn(celu.stock_disponible);
    WriteLn('Ingrese el stock minimo del celular: ');
    ReadLn(celu.stock_minimo);
end;

var
   archivoLogico:archivo;
   sinStock:Text;
   celu:celulares; 
   op:integer;
   name:String[20];
   flag:boolean;
begin
  WriteLn('---Menu---');
  WriteLn('0. Terminar');
  WriteLn('1. Agregar celular');
  WriteLn('2. Modificar stock');
  WriteLn('3. Exportar celulares sin stock');

  WriteLn('Elija una opcion:' );
  ReadLn(op);
  while(op <> 0)do
  begin
    case op of
        1:begin
            Assign(archivoLogico, 'celus.dat');
            Reset(archivoLogico);
            seek(archivoLogico, FileSize(archivoLogico));
            Leer(celu);
            Write(archivoLogico, celu);
            Close(archivoLogico);
          end;
        2:begin
            Assign(archivoLogico, 'celus.dat');
            Reset(archivoLogico);
            flag:= false;
            WriteLn('Ingrese el nombre del celular que desea modificar: ');
            ReadLn(name);
            while((not Eof(archivoLogico)) and (not flag))do
            begin
              Read(archivoLogico, celu);
              if(celu.nombre = name)then
              begin
                flag:= true;
                WriteLn('Modifique el stock: ');
                ReadLn(celu.stock_disponible);
                Seek(archivoLogico, FilePos(archivoLogico) - 1);
                Write(archivoLogico, celu);
              end;  
            end;
            Close(archivoLogico);
          end;  
        3:begin
            assign(archivoLogico, 'celus.dat');
            assign(sinStock, 'sinStock.txt');
            Reset(archivoLogico);
            Rewrite(sinStock);
            while(not Eof(archivoLogico))do
            begin
              Read(archivoLogico, celu);
              if(celu.stock_disponible = 0)then
              begin
                WriteLn(sinStock, celu.cod_celular, celu.precio,celu.marca);  
                WriteLn(sinStock, celu.stock_disponible, celu.stock_minimo,celu.descripcion);
                WriteLn(sinStock, celu.nombre);  
              end;  
            end;
            Close(sinStock);
            Close(archivoLogico);
          end;  
    else
       WriteLn('Opcion incorrecta'); 
    end;
      WriteLn('---Menu---');
      WriteLn('0. Terminar');
      WriteLn('1. Agregar celular');
      WriteLn('2. Modificar stock');
      WriteLn('3. Exportar celulares sin stock');

      WriteLn('Elija una opcion:' );
      ReadLn(op);
  end;
end.