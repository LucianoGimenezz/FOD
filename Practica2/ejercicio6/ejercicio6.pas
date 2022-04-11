// 6- Se desea modelar la información necesaria para un sistema de recuentos de casos de
// covid para el ministerio de salud de la provincia de buenos aires.
// Diariamente se reciben archivos provenientes de los distintos municipios, la información
// contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad casos
// activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
// fallecidos.
// El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
// nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos
// nuevos, cantidad recuperados y cantidad de fallecidos.
// Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
// recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
// localidad y código de cepa.
// Para la actualización se debe proceder de la siguiente manera:
// 1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
// 2. Idem anterior para los recuperados.
// 3. Los casos activos se actualizan con el valor recibido en el detalle.
// 4. Idem anterior para los casos nuevos hallados.
// Realice las declaraciones necesarias, el programa principal y los procedimientos que
// requiera para la actualización solicitada e informe cantidad de localidades con más de 50
// casos activos (las localidades pueden o no haber sido actualizadas).

program ejercicio6;
uses SysUtils;
const
  valor_alto = 9999;
type
  
  detail = record
    cod_localidad:integer;
    cod_cepa:integer;
    cant_casos_act:integer;
    cant_casos_nue:integer;
    cant_casos_recu:integer;
    cant_casos_fall:integer;
  end;

  maestro = record
    cod_localidad:integer;
    nombre_localidad:String[25];
    cod_cepa:integer;
    nombre_cepa:String[25];
    cant_casos_act:integer;
    cant_casos_nue:integer;
    cant_casos_recu:integer;
    cant_casos_fall:integer;
  end;

  file_maestro = file of maestro;
  file_detail = file of detail;

  vec_fileDetail = array[1..10]of file_detail;
  vec_reg_detail = array[1..10]of detail;

procedure leer(var detail:file_detail; var reg:detail);
begin
  if(not EoF(detail))then Read(detail,reg)
  else reg.cod_localidad:= valor_alto;
end;

procedure leerMaestro(var m:file_maestro; var reg:maestro);
begin
  if(not Eof(m))then Read(m, reg)
  else reg.cod_localidad:= valor_alto;
end;

procedure openFiles(var details:vec_fileDetail);
var
   i:integer;
begin
  for i:= 1 to 10 do
  begin
    Assign(details[i],'detail'+IntToStr(i));
    Reset(details[i]);
  end;
end;

procedure read_reg(var details:vec_fileDetail;var regs:vec_reg_detail);
var
  i:integer;
begin
  for i:= 1 to 10 do
    begin
       leer(details[i],regs[i]);
    end;
end;

procedure minimo(var regs:vec_reg_detail;var details:vec_fileDetail; var min:detail);
var
  i,indicemin:integer;
begin
    indicemin:= -1;
    min.cod_localidad:= 9999;
    min.cod_cepa:= 9999;
    for i:= 1 to 10 do
      begin
        if((regs[i].cod_localidad <= min.cod_localidad) and (regs[i].cod_cepa <= min.cod_cepa))then
          begin
            min:= regs[i];
            indicemin:= i;
          end;
      end;
      if(indicemin <> -1)then leer(details[indicemin], regs[indicemin]);
end;

procedure recorrerMaestro(var m:file_maestro);
var 
  codActual,reg:maestro;
  total:integer;
begin
  leerMaestro(m,reg);
  while(reg.cod_localidad <> valor_alto)do
    begin
      total:= 0;
      codActual:= reg;
      while(codActual.cod_localidad = reg.cod_localidad)do
        begin
          total:= total + reg.cant_casos_act;
          leerMaestro(m, reg);
        end;
        if(total > 50)then write('La localidad :', codActual.nombre_localidad, 'tiene mas de 50 casos activos');
    end;
    close(m);
end;

var
    i:integer;
    master:file_maestro;
    vecDetail:vec_fileDetail;
    vecReg:vec_reg_detail;
    min:detail;
    reg_master:maestro;
    codActual,codCepa,totalact,totalFallecidos,recuperados,totalnuevos:integer;
begin
  Assign(master,'maestro');
  Reset(master);
  openFiles(vecDetail);
  read_reg(vecDetail,vecReg);
  minimo(vecReg,vecDetail,min);
  while(min.cod_localidad <> valor_alto)do
    begin
        codActual:= min.cod_localidad;
        while(codActual = min.cod_localidad)do
          begin
             codCepa:= min.cod_cepa;
             totalFallecidos:= 0;
             recuperados:= 0; 
            while((codActual = min.cod_localidad) and (codCepa = min.cod_cepa))do
              begin
                  totalFallecidos:= totalFallecidos + min.cant_casos_fall;
                  recuperados:= recuperados + min.cant_casos_recu;
                  totalact:= min.cant_casos_act;
                  totalnuevos:= min.cant_casos_nue;
                  minimo(vecReg,vecDetail,min);
              end;
            read(master, reg_master);  
            while(reg_master.cod_localidad <> codActual)do Read(master,reg_master);
            while(reg_master.cod_cepa <> codCepa)do Read(master,reg_master);

            reg_master.cant_casos_act:= totalact;
            reg_master.cant_casos_nue:= totalnuevos;
            reg_master.cant_casos_fall:= reg_master.cant_casos_fall + totalFallecidos;
            reg_master.cant_casos_recu:= reg_master.cant_casos_recu + recuperados;

            Seek(master, FilePos(master) - 1);
            Write(master, reg_master);
          end;
    end; 
    recorrerMaestro(master);
    for i:=1 to 10 do
      begin
         close(vecDetail[i]);
      end;
end.