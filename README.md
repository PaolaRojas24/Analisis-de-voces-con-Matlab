# Análisis de voces con Matlab
Alumnos: </br>
 Daniel Castillo López A01737357 </br>
 Ana Itzel Hernández García A01737526 </br>
 Paola Rojas Domínguez A01737136 </br>
 ## Descripción
Desarrolla un programa computacional que analice la voz de las y los estudiantes del curso verificando si encuentra patrones e identificando claramente sus alcances y limitaciones.
## Etapas
### Grabación de audios
Primeramente, se grabaron 10 audios por cada alumno diciendo la palabra "Cerebot"
```
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
```
