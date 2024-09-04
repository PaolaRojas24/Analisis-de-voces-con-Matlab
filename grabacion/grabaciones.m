% se graban 3 segundos de audio
recObj = audiorecorder;
disp('Grabando ...');
recordblocking(recObj, 3);
disp('Fin de la grabación.');

% reproducción de la grabación
play(recObj);

% se obtiene el arreglo de la grabación
audio001 = getaudiodata(recObj);

% se grafica el arreglo
plot(audio001);
