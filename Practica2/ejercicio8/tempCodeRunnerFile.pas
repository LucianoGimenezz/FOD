program ejercicio8;
const
    valor_alto = 9999;
type    
    cliente = record
        cod:integer;
        nombre:String[20];
        apellido:String[20];
    end;

    master = record
        c:cliente;
        anio:integer;
        mes:integer;
        dia:integer;
        monto:real;
    end;

    mes_arr = array[1..12]of real;

    reporte = record
        c:cliente;
        totalAnio:real;
        totalxmes:mes_arr;
    end;

    master_file = file of master;
    report = file of reporte;

procedure leer(var m:master_file; var reg:master);
begin
    if(not Eof(m))then read(m,reg)
    else reg.c.cod:= valor_alto;
end;

procedure recorrerReporte(var r:report);
var                                                                                                  
 i:integer;
 total:real;
 reg:reporte;
begin
    total:= 0;
    Reset(r);
    while(not Eof(r))do
      begin
        Read(r, reg);
        Writeln('Lo gastado por el cliente ', reg.c.nombre, ' ,' , reg.c.apellido,',   con codigo', ' ', reg.c.cod);
        for i:= 1 to 12 do
          begin
            if(reg.totalxmes[i] <> 0)then  Writeln('Mes: ' , i, ' ,  Gasto: $', reg.totalxmes[i])
            else Writeln('Mes: ', i, ' ,  Gasto: $0');
          end;
          total:= total + reg.totalAnio;
          WriteLn('Gasto total en el anio: ', reg.totalAnio);
      end;
      Close(r);
      WriteLn('Total de ventas obtenidas de la empresa: ', total);
end;

procedure iniciar(var reg:reporte);
var
  i:integer;
begin
  for i:= 1 to 12 do
    reg.totalxmes[i]:= 0;
end;

var
  m:master_file;
  r:report;
  regM:master;
  regR:reporte;
  clienteActual:master;
  mesActual, anioActual:integer;  
  totalAnio, totalMes:real;
begin
  Assign(m,'maestro');
  Assign(r,'reporte');
  Reset(m);
  Rewrite(r);
  leer(m, regM);
  while(regM.c.cod <> valor_alto)do
    begin
        iniciar(regR);
        clienteActual:= regM;
        while(clienteActual.c.cod = regM.c.cod)do
          begin
            anioActual:= clienteActual.anio;
            totalAnio:= 0;
            while((clienteActual.c.cod = regM.c.cod) and (anioActual = regM.anio))do
            begin
                totalMes:= 0;
                mesActual:=regM.mes;
                while((clienteActual.c.cod = regM.c.cod) and (anioActual = regM.anio) and (mesActual = regM.mes))do
                begin
                    totalAnio:= totalAnio + regM.monto;
                    totalMes:= totalMes + regM.monto;
                    leer(m, regM);
                end;
                regR.c:= clienteActual.c;
                regR.totalxmes[mesActual]:= totalMes;
            end;
            regR.totalAnio:= totalAnio;
            Write(r, regR);
          end;
    end;
    close(m);
    Close(r);
    recorrerReporte(r);
end.