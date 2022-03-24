program act2;
type 
    archivo = file of integer;
var
    archivoLogico: archivo;
    archivoFisico: String[20];
    number, total,cant: integer;
    promedio: real;
begin
    cant:= 0;
    total:= 0;
    writeln('Ingrese el nombre del archivo ha abrir: ');
    readln(archivoFisico);
    assign(archivoLogico, archivoFisico);
    reset(archivoLogico);
    while(not EOF(archivoLogico))do
    begin
        read(archivoLogico, number);
        if(number < 1500)then cant:= cant + 1;
        total:= total + number;
        writeln(number);
    end;
    promedio:= totaL / filesize(archivoLogico);
    close(archivoLogico);
    writeln('Cantidad de numeros menores a 1500:  ',cant, '  Promedio:  ', promedio:2:2);
end.