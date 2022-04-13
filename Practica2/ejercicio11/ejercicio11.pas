// 11. A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
// archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
// alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
// agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
// localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
// necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
// NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
// pueden venir 0, 1 ó más registros por cada provincia.

program ejercicio11;
const
  valor_alto = 'ZZZ';
type
    maestro = record
        nombre:String[25];
        cant_persona_alfa:integer;
        total_encuestados:integer;
    end;

    detalle = record
        nombre:String[25];
        cod_localidad:integer;
        cant_alfa:integer;
        cant_encuestados:integer;
    end;

    file_maestro = file of maestro;
    file_detalle = file of detalle;

    arr_detalles = array[1..2]of file_detalle;
    reg_detalles = array[1..2]of detalle;

procedure leer(var d:file_detalle; var reg:detalle);
begin
  if(not Eof(d))then Read(d,reg)
  else reg.nombre:= valor_alto;
end;

procedure readRecords(var d:arr_detalles; var regs:reg_detalles);
var
 i:Integer;
begin
  for i:= 1 to 2 do
     leer(d[i], regs[i]);
end;

procedure minimo(var d:arr_detalles; var reg:reg_detalles;var min:detalle);
begin
  if(reg[1].nombre < reg[2].nombre)then 
    begin
      min:= reg[1];
      leer(d[1],reg[1]);
    end
    else 
      begin
        min:= reg[2];
        leer(d[2], reg[2]);
      end;
end;

var
   m:file_maestro;
   d:arr_detalles;
   reg:reg_detalles;
   totalAlf, totalEncues:integer; 
   min:detalle;
   prov_actual:String[25]; 
   regM:maestro;
begin
  Assign(m,'maestro');
  Assign(d[1],'detalle1');
  Assign(d[2], 'detalle2');
  Reset(m);
  Reset(d[1]);
  Reset(d[2]);
  readRecords(d,reg); 
  minimo(d,reg,min); 
  while(min.nombre <> valor_alto)do
    begin
        totalAlf:= 0;
        totalEncues:= 0;
        prov_actual:= min.nombre;
        while(prov_actual = min.nombre)do
          begin
             totalAlf += min.cant_alfa;
             totalEncues += min.cant_encuestados;
             minimo(d,reg,min);
          end;
        Read(m, regM);  
        while(regM.nombre <> prov_actual)do Read(m, regM);   
        Seek(m, FilePos(m) - 1);
        regM.total_encuestados += totalEncues;
        regM.cant_persona_alfa += totalAlf;
        Write(m, regM);
    end;
    Close(m);
    Close(d[1]);
    Close(d[2]);
end.