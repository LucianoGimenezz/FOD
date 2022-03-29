program ejercicio5;
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
var
   archivoLogico:archivo;
   archivoFisico:String[25];
   celu:celulares;
   celus:Text;
   op:integer;
begin
  WriteLn('Proporcione el nombre del archivo con el que desea trabajar: ');
  ReadLn(archivoFisico);
  WriteLn('---Menu---');
  WriteLn('0. Terminar');
  WriteLn('1. Crear archivo');
  WriteLn('2. Listar por stock');
  WriteLn('3. Listar por descripcion');
  WriteLn('4.Exportar archivo');
  WriteLn('Elija una opcion');
  ReadLn(op);

  while(op <> 0)do
  begin
    case op of
       1:begin
            assign(archivoLogico, archivoFisico);
            assign(celus, 'celulares.txt');
            Rewrite(archivoLogico);
            Reset(celus);
            while(not Eof(celus))do
            begin
              WriteLn('Comenzando Carga...');  
              ReadLn(celus, celu.cod_celular,celu.precio, celu.marca);
              ReadLn(celus, celu.stock_disponible, celu.stock_minimo, celu.descripcion);
              ReadLn(celus, celu.nombre);
              Write(archivoLogico, celu);
            end;
            Close(celus);
            Close(archivoLogico);
         end;
       2:begin
            assign(archivoLogico, archivoFisico);
            Reset(archivoLogico);
            while(not Eof(archivoLogico))do
            begin
              read(archivoLogico, celu);
              if(celu.stock_disponible < celu.stock_minimo) then WriteLn(celu.cod_celular, celu.nombre, celu.marca, celu.descripcion, celu.precio:2:2);
            end;
            Close(archivoLogico);
         end;    
        3: begin
             Write('TODO');
           end; 
        4:begin
            assign(archivoLogico, archivoFisico);
            assign(celus, 'celulares.txt');
            Reset(archivoLogico);
            Rewrite(celus);
            while(not Eof(archivoLogico))do
            begin
              read(archivoLogico, celu);
              WriteLn(celus, celu.cod_celular, celu.precio, celu.marca);
              WriteLn(celus, celu.stock_disponible, celu.stock_minimo, celu.descripcion);
              WriteLn(celus, celu.nombre);  
            end;
            Close(archivoLogico);
            Close(celus);
          end;   
    else
       WriteLn('Opcion incorrecta');
    end;
      WriteLn('---Menu---');
      WriteLn('0. Terminar');
      WriteLn('1. Crear archivo');
      WriteLn('2. Listar por stock');
      WriteLn('3. Listar por descripcion');
      WriteLn('4.Exportar archivo');
      WriteLn('Elija una opcion');
      ReadLn(op);
  end;  
end.