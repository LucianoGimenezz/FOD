program loadFile;
type  
     prov = record
        cod_provincia:integer;
        cod_localidad:integer;
        num_mesa:integer;
        cant_votos:integer;
     end;
  
    archivo = file of prov;
var
   file_:archivo;
   reg:prov; 
begin
    Assign(file_,'detail.dat');
    Rewrite(file_);
    while(reg.cod_provincia <> -1)do
      begin
        ReadLn(reg.cod_provincia);
        ReadLn(reg.cod_localidad);
        ReadLn(reg.num_mesa);
        ReadLn(reg.cant_votos);
        Write(file_, reg);
      end;
      Close(file_);
end.