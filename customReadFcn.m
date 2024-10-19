function data2 = customReadFcn(maskDir)
%create a reader object using the FileName
% reader = matlab.io.datastore.DsFileReader(fileInfoTbl.filename);
% 
% %seek to the offset
% seek(reader,fileInfoTbl.Offset,'Origin','start-of-file');
fileInfoTbl=maskDir;
out= load(fileInfoTbl);
%read fileInfoTbl.SplitSize amount of data
%data = read(reader,fileInfoTbl.SplitSize);
%data2= cell([2 1]);
% SD=out.M{:,1};
% %out = gatherLabelData(out.gTruth,[labelType.Polygon],'GroupLabelData','LabelType');
% % for i=1:78
% % SD(i,1)=double(out.M{50,1});
% % end
% T=struct2table(out);
% t=T.M{1,1};
% S=T.M{2,1};
% data= {t;S};
data2= struct2cell(out);

data2= data2{1,1};
%out = gatherLabelData(data2.gTruth,[labelType.Polygon],'GroupLabelData','LabelType');
% polygons = out{1}.PolygonData{1}(:,1);
% numPolygons1 = size(polygons,1);
% imageSize = [256 256]; % size(boats_im)
% maskStack1 = false([imageSize(1:2) numPolygons1]);

%---------------------------------------Codigo QUE FUNCIONA con UNA imagen
% polygons = out{1}.PolygonData{1}(:,1); %CAMBIAR AQUI  SEGUN LA IMAGEN A ENTRENAR 
% numPolygons = size(polygons,1);
% 
% %imageSize = [256 256]; % size(boats_im)
% imageSize = [256 256];
% maskStack = false([imageSize(1:2) numPolygons]);
% 
% 
% for i = 1:numPolygons
%       maskStack(:,:,i) = poly2mask(polygons{i}(:,1),polygons{i}(:,2),256,256);
% 
% end
% data2= maskStack;
%------------------------------------------------------------------------------
%---------------------------------------Codigo QUE FUNCIONA con UNA imagen
% polygons = out{1}.PolygonData{1}(:,1); %CAMBIAR AQUI  SEGUN LA IMAGEN A ENTRENAR 
% numPolygons = size(polygons,1);
% 
% %imageSize = [256 256]; % size(boats_im)
% imageSize = [256 256];
% maskStack = false([imageSize(1:2) numPolygons]);
% 
% arreglo= 
% 
% for i = 1:numPolygons
%       maskStack(:,:,i) = poly2mask(polygons{i}(:,1),polygons{i}(:,2),256,256);
% 
% end
% for j=1:78
% 
% end
% 
% data2= maskStack;
%------------------------------------------------------------------------------
% arregloo= [78 1];
% imagen = zeros(256,256,78);
% imageSize = [256 256];
% for j=1:78
%     polygons = out{1}.PolygonData{j}(:,1);
%     numPolygons = size(polygons,1);
%     maskStack = false([imageSize(1:2) numPolygons]);
%     for i = 1:numPolygons
%           maskStack(:,:,i) = poly2mask(polygons{i}(:,1),polygons{i}(:,2),256,256);   
%     end
%     for i =1:numPolygons
%         imagen(:,:,j) = imagen(:,:,j) + maskStack(:,:,i);
%     end
% 
%     s(j).field1=maskStack;
%     t=struct2table(s);
%     % if j>1 
%     % C = cat(3,C,maskStack);
%     % else
%     %      C=maskStack;
%     % end
%   %  arreglo(j,1)=A{j,:};
% %arreglo(j)= maskStack;
%     % figure
%     % L1= logical(imagen(:,:,j));
%     % imshow(L1);
% end
% %arreglo=A{:,:};
% %arreglo=struct2table(s.field1);
% 
% %disp(s.field1);
% T= t(:,:).field1(:,:);
% AR= table2array(t);
% %BA={1:78};
   
   % BA=AR{:,1};
    % data2= AR;
    % for i =1:78
    %     arregloo(i)=AR(i,1);
    % end
   % arregloo= data2(:,1);

 %   data2=s.field1;

%-------------------------------------------
% %data2= maskStack;
% polygons2 = out{1}.PolygonData{2}(:,1);
% numPolygons2 = size(polygons2,1);
% maskStack2 = false([imageSize(1:2) numPolygons2]);
% for i = 1:numPolygons2
%       maskStack2(:,:,i) = poly2mask(polygons2{i}(:,1),polygons2{i}(:,2),256,256);
% end

end


