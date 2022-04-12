program ejercicio10;
uses SysUtils;
const
  valor_alto = 9999 ;
type
    emple = record
        dep:integer;
        division:integer;
        num_emple:integer;
        categoria:integer;
        cant_hrs:integer;
    end;
    arr_valor = array[1..15]of real;

    archivo = file of emple;

procedure leer(var d:archivo; var reg:emple);
begin
  if(not Eof(d))then Read(d,reg)
  else reg.dep:= valor_alto;
end;


procedure load_values(var txt:Text ;var values:arr_valor);
var
  cat:Integer;
  monto:Real; 
begin
  Assign(txt,'values.txt');
  Reset(txt);  
  while(not Eof(txt))do
    begin
        ReadLn(txt,cat,monto);
        values[cat]:= monto;
    end;
    Close(txt);
end;
var
  file_:archivo;
  valores:arr_valor;
  valorestxt: Text;  
  reg:emple;
  categoria,depActual,divActual,empleActual,hrsxemple,hrsxdiv,hrsxdep:integer;
  montoxemple,montoxdiv,montoxdep:real;
begin  
  load_values(valorestxt,valores);
  Assign(file_, 'empleados.dat');
  Reset(file_);  
  leer(file_,reg);
  while(reg.dep <> valor_alto)do
    begin
        montoxdep:= 0;
        hrsxdep:= 0;
        depActual:= reg.dep;
        WriteLn('Departamento: ');
        WriteLn(' ',depActual,'  ');
        while(depActual = reg.dep)do
          begin
            divActual:= reg.division;
            hrsxdiv:= 0;
            montoxdiv:= 0;
            WriteLn('Division: ');
            WriteLn('  ',divActual,'  ');
            while((depActual = reg.dep) and (divActual = reg.division))do
            begin
              hrsxemple:= 0;
              montoxemple:= 0;
              empleActual:= reg.num_emple;
              categoria:= reg.categoria;
              while((depActual = reg.dep) and (divActual = reg.division) and (empleActual = reg.num_emple))do
              begin
                hrsxemple:= hrsxemple + reg.cant_hrs;
                leer(file_, reg);
              end;
              montoxemple:= valores[categoria] * hrsxemple;
              montoxdiv:= montoxdiv + montoxemple;
              hrsxdiv:= hrsxdiv + hrsxemple;
              hrsxdep:= hrsxdep + hrsxemple ;
              WriteLn('');
              WriteLn('Numero de empleado   Total de Hs    Importe a cobrar');
              WriteLn(  empleActual,'                    ', hrsxemple,'                      ',montoxemple:2:2);
            end;
            WriteLn('');
            WriteLn('Total de horas division: ', hrsxdiv);
            WriteLn('');
            WriteLn('Monto total division:  ', montoxdiv:2:2);
            montoxdep:= montoxdep + montoxdiv;
          end;
          WriteLn('');
          WriteLn('Total horas departamento: ', hrsxdep);
          WriteLn('');
          WriteLn('Monto total departamento: ', montoxdep:2:2);
    end;
    Close(file_);
end.