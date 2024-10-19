

%Parametros I=Imagen K= vecinos disk= apertura 
I = imread('Test/image021.jpg');
%K=2;
Gray=im2gray(I);
A=logical(imagen(:,:,21));
K=1;
radioMASK=0.001;
%graythresh(I) calcula un umbral global T a 
% partir de la imagen de escala de grises I empleando el método de Otsu
level=graythresh(Gray);
AccuracyArregloAT=zeros(100,1);
for v = 0.01:+0.01:1.0
    Tresh = adaptthresh(Gray,v);
    BinaryAT = not(imbinarize(Gray,Tresh));
    B=BinaryAT;

    if(isa(A,'logical'))
        X = A;
    else
        X = imbinarize(A);
    end
    if(isa(B,'logical'))
        Y = B;
    else
        Y = imbinarize(B);
    end
    
    % Evaluate TP, TN, FP, FN
    sumindex = X + Y;
    TP = length(find(sumindex == 2));
    TN = length(find(sumindex == 0));
    substractindex = X - Y;
    FP = length(find(substractindex == -1));
    FN = length(find(substractindex == 1));
    AccuracyAT = (TP+TN)/(FN+FP+TP+TN); %Analizar metrica pendiente------------------------
    AccuracyArregloAT(K)= AccuracyAT;
    
    K=K+1;
end

%-----------------------------------------------------------------
% imsegkmeans(I,k) segments image I into k clusters by performing 
%k-means clustering and returns the segmented labeled output in L.
AccuracyArreglo=zeros(4,4);
LabelsContador=1;
   for K = 1:4
        for L =1:K
            [Labels,~]= imsegkmeans(Gray,K);
            BinaryKMC = (Labels==L);
            B=BinaryKMC;
            if(isa(A,'logical'))
                X = A;
            else
                X = imbinarize(A);
            end
            if(isa(B,'logical'))
                Y = B;
            else
                Y = imbinarize(B);
            end
    
            % Evaluate TP, TN, FP, FN
            sumindex = X + Y;
            TP = length(find(sumindex == 2));
            TN = length(find(sumindex == 0));
            substractindex = X - Y;
            FP = length(find(substractindex == -1));
            FN = length(find(substractindex == 1));
            Accuracy = (TP+TN)/(FN+FP+TP+TN);
            AccuracyArreglo(K,L)= Accuracy;
        end
   end
  
%------------------------------------------KMC metricas
[Accuracy,K]= max(AccuracyArreglo);
[Accuracy,M]= max(Accuracy);
[Labels,~]= imsegkmeans(Gray,K(M));
BinaryKMC= (Labels==M);


B=BinaryKMC;

    if(isa(A,'logical'))
        X = A;
    else
        X = imbinarize(A);
    end
    if(isa(B,'logical'))
        Y = B;
    else
        Y = imbinarize(B);
    end
    
    % Evaluate TP, TN, FP, FN
    sumindex = X + Y;
    TP = length(find(sumindex == 2));
    TN = length(find(sumindex == 0));
    substractindex = X - Y;
    FP = length(find(substractindex == -1));
    FN = length(find(substractindex == 1));
    AccuracyNew = (TP+TN)/(FN+FP+TP+TN);
    SensitivityKMC = TP/(TP+FN);
    PrecisionKMC = TP/(TP+FP);
    IOU= TP/(TP+FP+FN);
    Recall= TP/(TP+FN);
    DICE=2*TP/(2*TP+FP+FN);
    F1Score= 2*PrecisionKMC*Recall/(PrecisionKMC+Recall);
    % DICE2= dice(A,B);
    
    
   % IOU2= jaccard(A,B);
 %Funciona  [Accuracy,I]= max(max(AccuracyArreglo));



%-----------------------------------------AT metricas


   [AccuracyAT,L]= max(AccuracyArregloAT);
   Tresh = adaptthresh(Gray,L*0.010);
    BinaryAT = not(imbinarize(Gray,Tresh));
    B=BinaryAT;

    if(isa(A,'logical'))
        X = A;
    else
        X = imbinarize(A);
    end
    if(isa(B,'logical'))
        Y = B;
    else
        Y = imbinarize(B);
    end
    
    % Evaluate TP, TN, FP, FN
    sumindex = X + Y;
    TP = length(find(sumindex == 2));
    TN = length(find(sumindex == 0));
    substractindex = X - Y;
    FP = length(find(substractindex == -1));
    FN = length(find(substractindex == 1));
    AccuracyATNew = (TP+TN)/(FN+FP+TP+TN);
    SensitivityAT = TP/(TP+FN);
    PrecisionAT = TP/(TP+FP);

     IOUAT= TP/(TP+FP+FN);
    RecallAT= TP/(TP+FN);
    DICEAT=2*TP/(2*TP+FP+FN);
    F1ScoreAT= 2*PrecisionAT*Recall/(PrecisionAT+Recall);
    

%----------------------------------------Impresion de resultados

   disp("KMC");
  % disp(I);
  % disp(Accuracy);
   disp(AccuracyNew);
   disp(SensitivityKMC);
   disp(PrecisionKMC);
   disp(IOU);
   disp(Recall);
   disp(DICE);
   disp(F1Score);
%    [Labels,~]= imsegkmeans(Gray,I);
%    BinaryKMC= (Labels==2);
   
   disp("AT");
  % disp(AccuracyAT);
   disp(AccuracyATNew);
   disp(SensitivityAT);
   disp(PrecisionAT);
     disp(IOUAT);
   disp(RecallAT);
   disp(DICEAT);
   disp(F1ScoreAT);
   Tresh = adaptthresh(Gray,L*0.01);
   BinaryAT = not(imbinarize(Gray,Tresh));
  

%---------------------------------SEMANTIC SEGMENTATION-----------------
testSeg = semanticseg(Gray,trainedNetwork_2);
t2=double(testSeg);
t2(t2<2)=1;
t2(t2>1)=0;
t2=imbinarize(t2);
B=t2;
    if(isa(A,'logical'))
        X = A;
    else
        X = imbinarize(A);
    end
    if(isa(B,'logical'))
        Y = B;
    else
        Y = imbinarize(B);
    end
    % Evaluate TP, TN, FP, FN
    sumindex = X + Y;
    TP = length(find(sumindex == 2));
    TN = length(find(sumindex == 0));
    substractindex = X - Y;
    FP = length(find(substractindex == -1));
    FN = length(find(substractindex == 1));
    AccuracySemantic = (TP+TN)/(FN+FP+TP+TN);
    SensitivitySemantic = TP/(TP+FN);
    PrecisionSemantic = TP/(TP+FP);
    IOUAT= TP/(TP+FP+FN);
    RecallAT= TP/(TP+FN);
    DICEAT=2*TP/(2*TP+FP+FN);
    F1ScoreAT= 2*PrecisionSemantic*Recall/(PrecisionSemantic+Recall);
    disp("SEMANTICA");
  % disp(L);
   disp(AccuracySemantic);
   disp(SensitivitySemantic);
   disp(PrecisionSemantic);
    disp(IOUAT);
   disp(RecallAT);
   disp(DICEAT);
   disp(F1ScoreAT);
   %---------------------------------MASKRCNN-----------------
%    AccuracyArregloAT=zeros(10,1);
% for v = 1:10
%     [masks,labels,scores,boxes] = segmentObjects(TT,I,Threshold=v*radioMASK);
% MASCARA = zeros(256,256);
% numpol=size(masks,3);
%  for i =1:numpol
%         MASCARA(:,:)= MASCARA(:,:) + masks(:,:,i);
%  end
%    % figure
%     F1= logical(MASCARA(:,:));
%     B=F1;
% 
%     if(isa(A,'logical'))
%         X = A;
%     else
%         X = imbinarize(A);
%     end
%     if(isa(B,'logical'))
%         Y = B;
%     else
%         Y = imbinarize(B);
%     end
% 
%     % Evaluate TP, TN, FP, FN
%     sumindex = X + Y;
%     TP = length(find(sumindex == 2));
%     TN = length(find(sumindex == 0));
%     substractindex = X - Y;
%     FP = length(find(substractindex == -1));
%     FN = length(find(substractindex == 1));
%     AccuracyAT = (TP+TN)/(FN+FP+TP+TN); %Analizar metrica pendiente------------------------
%     AccuracyArregloAT(v)= AccuracyAT;
% 
%     K=K+1;
% end
%  [AccuracyAT,L]= max(AccuracyArregloAT);
%  [masks,labels,scores,boxes] = segmentObjects(TT,I,Threshold=L*radioMASK);
%  MASCARA = zeros(256,256);
%  numpol=size(masks,3);
%  for i =1:numpol
%         MASCARA(:,:)= MASCARA(:,:) + masks(:,:,i);
%  end
%    % figure
%     F1= logical(MASCARA(:,:));
% %   Tresh = adaptthresh(Gray,L*0.010);
%   %  BinaryAT = not(imbinarize(Gray,Tresh));
%     % B=F1;
%     % 
%     % if(isa(A,'logical'))
%     %     X = A;
%     % else
%     %     X = imbinarize(A);
%     % end
%     % if(isa(B,'logical'))
%     %     Y = B;
%     % else
%     %     Y = imbinarize(B);
%     % end
%     % 
%     % % Evaluate TP, TN, FP, FN
%     % sumindex = X + Y;
%     % TP = length(find(sumindex == 2));
%     % TN = length(find(sumindex == 0));
%     % substractindex = X - Y;
%     % FP = length(find(substractindex == -1));
%     % FN = length(find(substractindex == 1));
%     % AccuracyATNew = (TP+TN)/(FN+FP+TP+TN);
%     % SensitivityAT = TP/(TP+FN);
%     % PrecisionAT = TP/(TP+FP);
%     % 
%     %  IOUAT= TP/(TP+FP+FN);
%     % RecallAT= TP/(TP+FN);
%     % DICEAT=2*TP/(2*TP+FP+FN);
%     % F1ScoreAT= 2*PrecisionAT*Recall/(PrecisionAT+Recall);
% 
%     %imshow(F1);
% % t2=double(testSeg);
% % t2(t2<2)=0;
% % t2(t2>1)=1;
% % t2=imbinarize(t2);
% B=F1;
%     if(isa(A,'logical'))
%         X = A;
%     else
%         X = imbinarize(A);
%     end
%     if(isa(B,'logical'))
%         Y = B;
%     else
%         Y = imbinarize(B);
%     end
%     % Evaluate TP, TN, FP, FN
%     sumindex = X + Y;
%     TP = length(find(sumindex == 2));
%     TN = length(find(sumindex == 0));
%     substractindex = X - Y;
%     FP = length(find(substractindex == -1));
%     FN = length(find(substractindex == 1));
%     AccuracySemantic = (TP+TN)/(FN+FP+TP+TN);
%     SensitivitySemantic = TP/(TP+FN);
%     PrecisionSemantic = TP/(TP+FP);
%     IOUAT= TP/(TP+FP+FN);
%     RecallAT= TP/(TP+FN);
%     DICEAT=2*TP/(2*TP+FP+FN);
%     F1ScoreAT= 2*PrecisionSemantic*Recall/(PrecisionSemantic+Recall);
%     disp("MASKRCNN");
%   % disp(L);
%    disp(AccuracySemantic);
%    disp(SensitivitySemantic);
%    disp(PrecisionSemantic);
%     disp(IOUAT);
%    disp(RecallAT);
%    disp(DICEAT);
%    disp(F1ScoreAT);
% 
% 
% 
% [masks,labels,scores,boxes] = segmentObjects(TT,I,Threshold=L*radioMASK);
% figure;
% overlayedImage = insertObjectMask(I,masks);
% imshow(overlayedImage)
% showShape("rectangle",boxes,Label=labels,LineColor=[1 0 0]);
% 
% figure;
%    disp(I*0.01);
%    disp(I);
%    figure;
%    imshow(BinaryKMC);
 figure;
subplot(1,5,1), imshow(BinaryKMC)
subplot(1,5,2), imshow(BinaryAT)
subplot(1,5,3), imshow(t2)
subplot(1,5,4), imshow(t2)
subplot(1,5,5), imshow(I)
% figure;
%    imshow(BinaryKMC);
%    figure;
%    imshow(BinaryAT);
%    figure;
%    imshow(t2);
%    figure;
%    imshow(F1);
%       figure;
%    imshow(Gray);