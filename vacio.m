close all;
clear all;
instrreset;
%%
%
presion = serial('COM14','BaudRate',9600,'DataBits',8,'StopBits',1,'Parity','none', 'terminator','CR') ;

multimetro = serial('COM16','BaudRate',9600,'DataBits',8,'StopBits',1,'Parity','none');

set(multimetro,'terminator','CR','InputBufferSize',15,'ReadAsyncMode','manual');

fopen(presion);

fopen(multimetro);
%% MEDICION SIMPLES
verbose=0;
[Ylab , valueMultimetro, str, count] = amprobe38XRA(multimetro, verbose);
fprintf('Valor: %g %s \n',valueMultimetro,Ylab);

strpresion = query(presion,'?GA1'); 
%derecha esta midiendo sobre el platino
%izquierda esta midiendo sobre la R de 1 ohm

%26 de junio medimos 

M = 3000;
pausa = 2;
nombre = 'enfriamientodifusora';
% NumeroTotal_Proceso_Descripcion_NumeroParcial

Tiempo =  zeros(1,M);
Temperatura = zeros(1,M);
Presion = zeros(1,M);
tic

archivo_de_datos = strcat(nombre,'.txt');       %crea el nombre del archivo de datos
FILE = fopen(archivo_de_datos,'at');
fprintf(FILE,'%s\n','$ Medicion  ;  Tiempo   ;  Presion ; Temperatura ' ); %agregar presion
% fprintf(FILE,'%s\n',' pausa = ');
% fprintf(FILE,'%f', pausa);




for k = 1:M
    disp('midiendo')
    Tiempo(k)=toc;
    Presion(k)=str2double(query(presion,'?GA1')) ;
    [Ylab , valueMultimetro, str, count] = amprobe38XRA(multimetro,verbose);
    Temperatura(k)= valueMultimetro;
%       drawnow
       figure(1);
       plot(Tiempo(1:k),Presion(1:k), '.')
       figure(2);
       plot(Tiempo(1:k),Temperatura(1:k), '.')
       %  figure(3);
      % plot(Presion(1:k), VoltajeIzquierda(1:k)./VoltajeDerecha(1:k))
       fprintf(FILE,'%1.0d',k);
       fprintf(FILE,'%s',' ; ');
       fprintf(FILE,'%f',Tiempo(k));
       fprintf(FILE,'%s',' ; ');
       fprintf(FILE,'%f',Presion(k));
       fprintf(FILE,'%s',' ; ');       
       fprintf(FILE,'%f',Temperatura(k));
       fprintf(FILE,'\n');       
       disp(k)
       %save(archivo_de_datos,'-append', k, Tiempo(k), Presion(k), Temperatura(k))
       pause(pausa);
end
disp('Ya termino')
fclose(FILE);

%plot(TIME',DATA')


% csvwrite('tiempo.txt',Tiempo)
% csvwrite('presion.txt',Presion)
%'C:\Users\publico.LABORATORIOS\Desktop\grupo 5\matlabScripts\Presion19dejunio80mA.dat','Presion','-ascii','-double')
% csvwrite('temperatura.txt',Temperatura)
%'C:\Users\publico.LABORATORIOS\Desktop\grupo 5\matlabScripts\VoltajeDerecha19dejunio80mA.dat','VoltajeDerecha','-ascii','-double')




%otras cosas que se pueden medir
% MEASure
%  :VOLTage:DC? {<range>|MIN|MAX|DEF},{<resolution>|MIN|MAX|DEF}
%  :VOLTage:DC:RATio? {<range>|MIN|MAX|DEF},{<resolution>|MIN|MAX|DEF}
%  :VOLTage:AC? {<range>|MIN|MAX|DEF},{<resolution>|MIN|MAX|DEF}
%  :CURRent:DC? {<range>|MIN|MAX|DEF},{<resolution>|MIN|MAX|DEF}
%  :CURRent:AC? {<range>|MIN|MAX|DEF},{<resolution>|MIN|MAX|DEF}
%  :RESistance? {<range>|MIN|MAX|DEF},{<resolution>|MIN|MAX|DEF}
%  :FRESistance? {<range>|MIN|MAX|DEF},{<resolution>|MIN|MAX|DEF}
%  :FREQuency? {<range>|MIN|MAX|DEF},{<resolution>|MIN|MAX|DEF}
%  :PERiod? {<range>|MIN|MAX|DEF},{<resolution>|MIN|MAX|DEF}
%  :CONTinuity?
%  :DIODe?


%% cierra la sesión con mm
fclose(multimetro);
fclose(presion);
%delete(multimetro);