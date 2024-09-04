% se graban 3 segundos de audio
recObj = audiorecorder;
disp('Grabando ...');
recordblocking(recObj, 3);
disp('Fin de la grabación.');

% reproducción de la grabación
play(recObj);

% se obtiene el arreglo de la grabación
oscar001 = getaudiodata(recObj);

% se grafica el arreglo
plot(oscar001);

% se guarda la grabación en un archivo WAV
%filenameWAV = 'oscar001.wav';
%audiowrite(filenameWAV, oscar001, recObj.SampleRate);
%disp(['Grabación guardada como ', filenameWAV]);