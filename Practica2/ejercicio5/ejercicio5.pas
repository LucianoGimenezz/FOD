// 5. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
// toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
// información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
// en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
// reuniendo dicha información.
// Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
// nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
// del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
// padre.
// En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
// apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
// lugar.
// Realizar un programa que cree el archivo maestro a partir de toda la información de los
// archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
// apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
// apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
// además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
// deberá, además, listar en un archivo de texto la información recolectada de cada persona.
// Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
// Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
// además puede no haber fallecido.

program ejercicio5;
uses SysUtils;
const
    valor_alto = 9999;
type
    direc = record
        calle:String[20];
        nro:integer;
        piso:integer; //opcionales
        depto:integer; //opcionales
        ciudad:String[25];
    end;

    acta_nacimiento = record
        nro_partida_nacimiento:integer;
        nombre:String[20];
        apellido:String[20];
        direccion:direc;
        matricula_medico:integer;
        nombre_madre:String[20];
        apellido_madre:String[20];
        dni_madre:String[10];
        nombre_padre:String[20];
        apellido_padre:String[20];
        dni_padre:String[10];
    end;

    acta_fallecimiento = record
        nro_partida_nacimiento:integer;
        dni:String[20];
        nombre:String[20];
        apellido:String[20];
        matricula_medico:integer;
        fecha:String[20];
        hora:String[15];
        lugar:String[30];
    end;

    file_maestro = record
        nro_partida_nacimiento:integer;
        nombre:String[20];
        apellido:String[20];
        direccion:direc;
        matricula_medico:integer;
        nombre_madre:String[20];
        apellido_madre:String[20];
        dni_madre:String[10];
        nombre_padre:String[20];
        apellido_padre:String[20];
        dni_padre:String[20];
        fallecio:boolean;
        matricula_medico_deceso:integer;
        fecha:String[20];
        hora:String[15];
        lugar:String[20];
    end;

    type_maestro = file of file_maestro;
    detail_nacimiento = file of acta_nacimiento;
    detail_fallecimiento = file of acta_fallecimiento;

    vec_details_nacimiento = array[1..50]of detail_nacimiento;
    vec_details_fallecimiento = array[1..50]of detail_fallecimiento;

    vec_reg_nacimiento = array[1..50] of acta_nacimiento;
    vec_reg_fallecimiento = array[1..50] of acta_fallecimiento;

procedure leer(var detail:detail_nacimiento; var reg:acta_nacimiento);
begin
  if(not Eof(detail)) then read(detail, reg)
  else reg.nro_partida_nacimiento:= valor_alto;
end;

procedure leer2(var detail:detail_fallecimiento; var reg:acta_fallecimiento);
begin
  if(not Eof(detail)) then read(detail, reg)
  else reg.nro_partida_nacimiento:= valor_alto;
end;


procedure open_all_file(var arr:vec_details_nacimiento);
var
  i:integer;  
begin
  for i:= 1 to 50 do
    begin
        Assign(arr[i],'detail'+IntToStr(i));
        Reset(arr[i]);
    end;
end;


procedure open_all_file2(var arr:vec_details_fallecimiento);
var
  i:integer;  
begin
  for i:= 1 to 50 do
    begin                                                            
        Assign(arr[i],'detail'+IntToStr(i));
        Reset(arr[i]);
    end;
end;

procedure read_reg(var arr:vec_details_nacimiento; var arr_reg:vec_reg_nacimiento);
var
   i:integer;
begin
  for i:= 1 to 50 do
  begin
    leer(arr[i], arr_reg[i]);
  end;
end; 

procedure read_reg2(var arr:vec_details_fallecimiento; var arr_reg:vec_reg_fallecimiento);
var
   i:integer;
begin
  for i:= 1 to 50 do
  begin
    leer2(arr[i], arr_reg[i]);
  end;
end;

procedure minimo(var vec:vec_reg_nacimiento; var min:acta_nacimiento; var vec_actas:vec_details_nacimiento);
var
 i, indice_min:integer;
begin
  min.nro_partida_nacimiento:= 9999;
  indice_min:= -1;
  for i:= 1 to 50 do
    begin
       if(vec[i].nro_partida_nacimiento < min.nro_partida_nacimiento)then
         begin
           min:= vec[i];
           indice_min:= i;
         end; 
    end;
    if(indice_min <> -1)then leer(vec_actas[indice_min], vec[indice_min]);
end;

procedure load_file_master(var regMaestro:file_maestro; min:acta_nacimiento; acta_f:acta_fallecimiento);
begin
    regMaestro.nro_partida_nacimiento:= min.nro_partida_nacimiento;
    regMaestro.nombre:= min.nombre;
    regMaestro.apellido:= min.apellido;
    regMaestro.direccion:= min.direccion;
    regMaestro.matricula_medico:= min.matricula_medico;
    regMaestro.nombre_madre:= min.nombre_madre;
    regMaestro.apellido_madre:= min.apellido_madre;
    regMaestro.dni_madre:= min.dni_madre;
    regMaestro.nombre_padre:= min.nombre_padre;
    regMaestro.apellido_padre:= min.apellido_padre;
    regMaestro.dni_padre:= min.dni_padre;
    regMaestro.fallecio:= true;
    regMaestro.matricula_medico_deceso:= acta_f.matricula_medico;
    regMaestro.fecha:= acta_f.fecha;
    regMaestro.hora:= acta_f.hora;
    regMaestro.lugar:= acta_f.lugar;
end;

procedure load_file_text(var file_text: Text; var file_master:type_maestro);
var
  reg:file_maestro;
begin
    while(not Eof(file_master))do
      begin
         read(file_master, reg);
         if(reg.fallecio)then
           begin
                Writeln(file_text, reg.nro_partida_nacimiento,' ', reg.nombre,' ', reg.apellido, ' ' ,reg.matricula_medico);
                WriteLn(file_text, reg.nombre_madre, ' ', reg.apellido_madre, ' ', reg.dni_madre, ' ', reg.nombre_padre, ' ', reg.apellido_padre);
                WriteLn(file_text, reg.dni_padre, ' fallecio ',' ', reg.matricula_medico_deceso, ' ', reg.fecha, ' ', reg.hora, ' ', reg.lugar);
                WriteLn(file_text, reg.direccion.calle,' ',  reg.direccion.nro,' ', reg.direccion.piso,' ', reg.direccion.depto,' ', reg.direccion.ciudad);
           end
           else 
             begin
                 Writeln(file_text, reg.nro_partida_nacimiento,' ', reg.nombre,' ', reg.apellido, ' ' ,reg.matricula_medico);
                 WriteLn(file_text, reg.nombre_madre, ' ', reg.apellido_madre, ' ', reg.dni_madre, ' ', reg.nombre_padre, ' ', reg.apellido_padre);
                 WriteLn(file_text, reg.direccion.calle,' ',  reg.direccion.nro,' ', reg.direccion.piso,' ', reg.direccion.depto,' ', reg.direccion.ciudad);
                 WriteLn(file_text, reg.dni_padre, ' ', 'No fallecio');
             end;
      end;
end;

var
    arr_act_nacimiento:vec_details_nacimiento;
    arr_act_fallecimiento:vec_details_fallecimiento;
    maestro_file:type_maestro;
    arr_registros_nacimiento:vec_reg_nacimiento;
    min:acta_nacimiento;
    reg:acta_fallecimiento;
    reg_master:file_maestro;
    flag:boolean;
    i:integer;
    file_text: Text;
begin  
  Assign(file_text, 'datos.txt');
  Assign(maestro_file, 'maestro');
  Rewrite(maestro_file);
  Rewrite(file_text);
  open_all_file(arr_act_nacimiento);
  open_all_file2(arr_act_fallecimiento);
  read_reg(arr_act_nacimiento,arr_registros_nacimiento);
  minimo(arr_registros_nacimiento, min, arr_act_nacimiento);
  while(min.nro_partida_nacimiento <> valor_alto )do
  begin
    flag:= false;
    i:= 1;
    while((not flag) and (i <= 50))do
      begin
         seek(arr_act_fallecimiento[i], 0);
         while((not Eof(arr_act_fallecimiento[i])) and (not flag))do
           begin
                read(arr_act_fallecimiento[i], reg);
                if(reg.nro_partida_nacimiento = min.nro_partida_nacimiento)then flag:= true;
           end;
        if(flag)then
         begin
            load_file_master(reg_master,min,reg);
            Write(maestro_file, reg_master);
         end
         else i:= i + 1;
      end;
    minimo(arr_registros_nacimiento, min, arr_act_nacimiento);
  end;
  load_file_text(file_text, maestro_file);
  close(file_text);
  close(maestro_file);
  for i:= 1 to 50 do
    begin
        close(arr_act_nacimiento[i]);
        close(arr_act_fallecimiento[i]);
    end;
end.