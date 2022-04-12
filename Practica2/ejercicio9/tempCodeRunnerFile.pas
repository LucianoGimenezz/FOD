
program ejercicio9;
const 
    valor_alto = 9999;
type
    prov = record
        cod_provincia:integer;
        cod_localidad:integer;
        num_mesa:integer;
        cant_votos:integer;
    end;
  
    archivo = file of prov;

procedure leer(var d:archivo; var reg:prov);
begin
  if(not Eof(d))then Read(d,reg)
  else reg.cod_provincia:= valor_alto;
end;

var
   provActual, locActual, totalvotos,votosLocal,votosProv:integer;
   detail:archivo;
   reg:prov; 
begin
  totalvotos:= 0;  
  Assign(detail, 'detail.dat');
  Reset(detail);
  leer(detail,reg);
  while(reg.cod_provincia <> valor_alto)do
    begin
        provActual:= reg.cod_provincia;
        votosProv:= 0;
        WriteLn('Codigo de provincia: ', provActual);
        while(provActual = reg.cod_provincia)do
          begin
              votosLocal:= 0;
              locActual:= reg.cod_localidad;  
              while((provActual = reg.cod_provincia) and (locActual = reg.cod_localidad))do
              begin
                votosLocal:=votosLocal + reg.cant_votos;
                leer(detail, reg);
              end;
              WriteLn('Codigo de localidad          Total votos');
              WriteLn(locActual,'        ',votosLocal);
              votosProv:= votosProv + votosLocal;
          end;
          totalvotos:= totalvotos + votosProv;
          WriteLn('Total de votos provincia: ', votosProv);
    end;  
    Close(detail);
    WriteLn('Total general de votos: ', totalvotos);
end.