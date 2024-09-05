# Análisis de voces con Matlab
Alumnos: </br>
 Daniel Castillo López A01737357 </br>
 Ana Itzel Hernández García A01737526 </br>
 Paola Rojas Domínguez A01737136 </br>
 ## Descripción
Desarrollar un programa computacional que analice la voz de las y los estudiantes del curso verificando si encuentra patrones e identificando claramente sus alcances y limitaciones.
## Etapas
### Grabación de audios
Primeramente, se grabaron 10 audios por cada alumno diciendo la palabra "Cerebot".
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
Posteriormente, utilizando matlab, se aumentó cada audio para tener un total de 110 audios por persona y con estos entrenar el modelo
### Creación del Dataset y extracción de features
Para la creación del dataset se extrajeron todos los audios de cada alumno que se encontraban en su propia carpeta, una vez almacenados en el data set se seaparaon para que el 80% de los datos sirvieran para entrenar al modelo y el 20% para las pruebas.
Posteriormente, se ralizó la extracción de features con un energyThreshold = 0.02 y un zcrThreshold = 0.3. Después de que se obtuvieran los fetures de todos los archivos, se ubtuvieorn la media y desviación estándar.
### Modelo knn
Le modelo knn (o de número de vecinos) es un clasificador de aprendizaje supervisado no paramétrico, que utiliza la proximidad para hacer clasificaciones o predicciones sobre la agrupación de un punto de datos individual. Para nuestro modelo se utilizo una k = 10;
```
trainedClassifier = fitcknn(features,labels, ...
    Distance="euclidean", ...
    NumNeighbors=5, ...
    DistanceWeight="squaredinverse", ...
    Standardize=false, ...
    ClassNames=unique(labels));
k = 10;
group = labels;
c = cvpartition(group,KFold=k); % 5-fold stratified cross validation
partitionedModel = crossval(trainedClassifier,CVPartition=c);
validationAccuracy = 1 - kfoldLoss(partitionedModel,LossFun="ClassifError");
fprintf('\nValidation accuracy = %.2f%%\n', validationAccuracy*100);
```
Esto nos da una precisión de validación: 98.42% </br>
A continuación se presenta la matriz de confusión correspondiente:
```
validationPredictions = kfoldPredict(partitionedModel);
figure(Units="normalized",Position=[0.4 0.4 0.4 0.4])
confusionchart(labels,validationPredictions,title="Validation Accuracy", ...
    ColumnSummary="column-normalized",RowSummary="row-normalized");
```
![accuracy](https://github.com/user-attachments/assets/7aa21282-16b3-4587-812a-693ba98475c8)
### Prueba del modelo
Para porbar su veracidad se utilizaron el 20% de los datos restantes y se graficaron en dos matriz de confusión, per frame
```
features = (features-M)./S;
prediction = predict(trainedClassifier,features);
prediction = categorical(string(prediction));
figure(Units="normalized",Position=[0.4 0.4 0.4 0.4])
confusionchart(labels(:),prediction,title="Test Accuracy (Per Frame)", ...
    ColumnSummary="column-normalized",RowSummary="row-normalized");
```
![perframe](https://github.com/user-attachments/assets/f0bd7f2a-ffd7-43a4-9eaa-253cfc42e2da)
Y por archivo
```
r2 = prediction(1:numel(adsTest.Files));
idx = 1;
for ii = 1:numel(adsTest.Files)
    r2(ii) = mode(prediction(idx:idx+numVectorsPerFile(ii)-1));
    idx = idx + numVectorsPerFile(ii);
end

figure(Units="normalized",Position=[0.4 0.4 0.4 0.4])
confusionchart(adsTest.Labels,r2,title="Test Accuracy (Per File)", ...
    ColumnSummary="column-normalized",RowSummary="row-normalized");
```
![perfile](https://github.com/user-attachments/assets/93cc6dbe-0013-4bbb-88a7-55a05f2a2fcc)
Gracias a esto podemos deducir que el modelo funciona y es preciso la mayoría de las veces
## Aplicación
La interfaz cuenta con un botón de grabado de audio, una caja que muestra el mensaje "Grabando..." y "Fin de la grabación", un botón para activar el modelo y que prediga quién es la persona que habló y su respectiva caja de texto para mostrar el resultado.
![Imagen de WhatsApp 2024-09-02 a las 22 31 01_6448021e](https://github.com/user-attachments/assets/1a3ecc18-44ff-44a5-b068-e441f46b0949)
Video demostrarivo: https://youtu.be/uf8myY6_zPA
