program ejercicio2;
const
  valorAlto = 9999;
type
    alumno = record
        cod_alumno:integer;
        apellido:String[25];
        nombre:String[25];
        cant_materias_sin_final:integer;
        cant_materias_con_final:Integer;
    end;

    detail = record
        cod_alumno:integer;
        aprop_con_final:Boolean;
    end;

    file_maestro = file of alumno;
    file_detalle = file of detail;
procedure Leer(var detail:file_detalle; var alu:detail);
begin
  if(not Eof(detail))then Read(detail, alu)
  else alu.cod_alumno:= valorAlto;
end;

procedure update(var fileM:file_maestro; var fileD: file_detalle);
var
  d:detail;
  alu:alumno;
  conFinal:integer;
  sinFinal:Integer;
  aux:integer;
begin
  Assign(fileM, 'maestro');
  Assign(fileD, 'detail');
  Reset(fileM);
  Reset(fileD);
  if(not Eof(fileM))then
     Read(fileM, alu);
  Leer(fileD, d);
  while(d.cod_alumno <> valorAlto)do
       conFinal:= 0;
       sinFinal:= 0;
       aux:= d.cod_alumno;
       while(aux = d.cod_alumno)do
         begin
            if(d.aprop_con_final)then conFinal:= conFinal + 1
            else sinFinal:= sinFinal + 1;
            Leer(fileD, d);
         end;
         while(aux <> alu.cod_alumno)do
            read(fileM, alu);
        alu.cant_materias_sin_final:= alu.cant_materias_sin_final + sinFinal;
        alu.cant_materias_con_final:= alu.cant_materias_con_final + conFinal;
        seek(fileM, FilePos(fileM) - 1);
        Write(fileM, alu);
        if(not Eof(fileM))then Read(fileM, alu);
end;

procedure listar(var maestro_file: file_maestro; var aluT: Text);
var
   alu:alumno; 
begin
  Assign(maestro_file, 'maestro');
  Assign(aluT, 'alumnos.txt');
  Reset(maestro_file);
  Rewrite(aluT);
  while(not Eof(maestro_file))do
    begin
      Read(maestro_file, alu);
      if(alu.cant_materias_sin_final > 4)then 
      begin
        WriteLn(aluT, alu.cod_alumno, alu.apellido, alu.nombre);
        WriteLn(aluT, alu.cant_materias_sin_final, alu.cant_materias_con_final);
      end;  
    end;
end;

var
    maestro:file_maestro;
    detail_file:file_detalle;
    op:integer;
    aluText:Text;
begin
    WriteLn('--Menu--');
    WriteLn('1. Actualizar maestro');
    WriteLn('2. Listar alumnos');

    WriteLn('Elija una opcion: ');
    ReadLn(op);
    if(op = 1) then update(maestro, detail_file)
    else listar(maestro, aluText);
end.