program ejercicio3;
type
   novel = record
    cod:integer;
    nombre:String[25];
    genero:String[25];
    duracion:integer;
    director:String[25];
    precio:real;
   end; 

   archivo = file of novel;
procedure leer(var reg:novel);
begin
  WriteLn('Ingrese el nombre de la novela: ');
  ReadLn(reg.nombre);
  if(reg.nombre <> 'fin')then
    begin
        WriteLn('Ingrese el codigo de la novela: ');
        ReadLn(reg.cod);
        WriteLn('Ingrese el genero de la novela: ');
        ReadLn(reg.genero);
        WriteLn('Ingrese el director de la novela: ');
        ReadLn(reg.director);
        WriteLn('Ingrese la duracion de la novela: ');
        ReadLn(reg.duracion);
        WriteLn('Ingrese el precio de la novela: ');
        ReadLn(reg.precio);
    end;
end;

var
begin
  
end.