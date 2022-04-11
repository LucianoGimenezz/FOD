// 4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
// fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
// máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
// archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
// cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
// cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
// detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
// tiempo_total_de_sesiones_abiertas.
// Notas:
// - Cada archivo detalle está ordenado por cod_usuario y fecha.
// - Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
// máquinas.
// - El archivo maestro debe crearse en la siguiente ubicación física: /var/log.


program ejercicio4;
uses SysUtils;
const 
  valor_alto = 9999;
type
    date_record = record
        day:integer;
        month:integer;
        year:integer;
    end;

    session_detail = record
        cod_user:integer;
        date:date_record;
        session_time:integer;
    end;

    session_master = record
        cod_user:integer;
        date:date_record;
        total_session_time:Integer;
    end;

    file_master = file of session_master;
    file_detail = file of session_detail;

    array_detail = array[1..5] of file_detail;
    array_reg_detail = array[1..5] of session_detail;

procedure Leer(var detail:file_detail; var reg:session_detail);
begin
    if(not Eof(detail))then Read(detail, reg)
    else reg.cod_user:= valor_alto;
end;

procedure initFiles(var vec:array_detail);
var
  i:integer;
begin
  for i:= 1 to 5 do
    begin
       Assign(vec[i], 'detail'+IntToStr(i)+ '.dat');  
       Reset(vec[i]);
    end;
end;

procedure read_reg(var arr_detail:array_detail; var arr_reg:array_reg_detail);
var
  i:Integer;
begin      
  for i:= 1 to 5 do
  begin
    Leer(arr_detail[i], arr_reg[i]);
  end;
end;


procedure minimo(var regs:array_reg_detail; var min:session_detail; var details_arr: array_detail);
var
  i:integer;
  indice_min:integer;                                                                            
begin
  min.cod_user:= 9999;  
  indice_min:= -1;
  for i:= 1 to 5 do
   begin
     if(regs[i].cod_user <= min.cod_user)then
     begin
       min.cod_user:= regs[i].cod_user;
       indice_min:= i;
     end;
   end;
   if(indice_min <> -1)then leer(details_arr[indice_min], regs[indice_min]);
end;

procedure closeAllFiles(var vec:array_detail);
var
  i:integer;
begin
  for i:= 1 to 5 do close(vec[i]);
end;

var
    maestro:file_master;
    vec:array_detail;
    vec_reg:array_reg_detail;
    reg_master:session_master;
    min:session_detail;
begin
  Assign(maestro, '/var/log/maestro.dat');
  Rewrite(maestro);
  initFiles(vec);
  read_reg(vec, vec_reg);  
  minimo(vec_reg, min, vec);
  while(min.cod_user <> valor_alto)do
    begin
        reg_master.cod_user:= min.cod_user;
        reg_master.total_session_time:= 0;
        while(reg_master.cod_user = min.cod_user)do
        begin
            reg_master.total_session_time:= reg_master.total_session_time + min.session_time;
            reg_master.date:= min.date;
            minimo(vec_reg, min, vec);
        end;
        Write(maestro, reg_master);
    end;
    close(maestro);
    closeAllFiles(vec);
end.