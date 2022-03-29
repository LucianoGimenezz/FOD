program ejercicio7;
type
    novela = record
       cod_novela:integer;
       nombre:String[25];
       genero:String[25];
       precio:real;
    end;   
    archivo = file of novela;
procedure Leer(var novel:novela);
begin
  WriteLn('Ingrese el codigo de la novela: ');
  ReadLn(novel.cod_novela);
  WriteLn('Ingrese el nombre: ');
  ReadLn(novel.nombre);
  WriteLn('Ingrese el genero: ');
  ReadLn(novel.genero);
  WriteLn('Ingrese el precio');
  ReadLn(novel.precio);
end;
var
    archivoFisico:String[24];
    archivoLogico:archivo;
    novel:novela;
    novelas:Text;
    op:integer;
    nombre:String[20];
    flag:boolean;
begin
  WriteLn('Ingrese el nombre del archivo binario: ');
  ReadLn(archivoFisico);
  WriteLn('---Menu---');
  WriteLn('0. Terminar');
  WriteLn('1. Crear archivo');
  WriteLn('2. Agregar novela');
  WriteLn('3. Modificar novela');

  WriteLn('Elija una opcion');
  ReadLn(op);

  while(op <> 0)do
  begin
      case op of
        1:begin
            Assign(archivoLogico, archivoFisico);
            Assign(novelas,'novelas.txt');
            Rewrite(archivoLogico);
            Reset(novelas);
            while(not Eof(novelas))do
            begin
              readln(novelas, novel.cod_novela, novel.precio, novel.genero);
              ReadLn(novelas, novel.nombre);
              Write(archivoLogico, novel);
            end;
            Close(archivoLogico);
            Close(novelas);
          end;
        2:begin
            Assign(archivoLogico, archivoFisico);
            Reset(archivoLogico);
            seek(archivoLogico, FileSize(archivoLogico));
            Leer(novel);
            Write(archivoLogico, novel);
            Close(archivoLogico);
          end;  
        3:begin
            flag:= false;
            Assign(archivoLogico, archivoFisico);
            Reset(archivoLogico);
            WriteLn('Ingrese el nombre de la novela ha modificar: ');
            ReadLn(nombre);
            while((not Eof(archivoLogico)) and (not flag))do
            begin
              Read(archivoLogico, novel);
              if(novel.nombre = nombre)then
              begin
                flag:= true;
                WriteLn('Modifique el nombre: ');
                ReadLn(novel.nombre);
                WriteLn('Modifique el genero: ');
                ReadLn(novel.genero);
                WriteLn('Modifique el precio: ');
                ReadLn(novel.precio);
                WriteLn('Modifique el codigo: ');
                ReadLn(novel.cod_novela);
              end;
            end; 
            Close(archivoLogico); 
          end;  
      else
        WriteLn('Opcion incorrecta');  
      end;  
      WriteLn('---Menu---');
      WriteLn('0. Terminar');
      WriteLn('1. Crear archivo');
      WriteLn('2. Agregar novela');
      WriteLn('3. Modificar novela');

      WriteLn('Elija una opcion');
      ReadLn(op);
  end;  
end.