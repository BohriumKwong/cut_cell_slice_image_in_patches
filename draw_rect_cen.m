function result=draw_rect_cen(data,cent_point,windSize,showOrNot,Color,filename,num,First_d,if_write)
% �������ã�[state,result]=draw_rect(data,pointAll,windSize,showOrNot)
% �������ܣ���ͼ�񻭸������ο�
% �������룺dataΪԭʼ�Ĵ�ͼ����Ϊ�Ҷ�ͼ����Ϊ��ɫͼ
%          cent_point ��������ڴ�ͼ�е�����(ÿ�д���һ������)��
%          windSize ��ı߳���С
%          showOrNot �Ƿ�Ҫ��ʾ,Ĭ��Ϊ��ʾ����
%          Color ��Ҫ��ȡ�ı����ɫ��lymphocyte--red,'r'
%                                   plasma cell--yellow,'y'
%                                   cancer cell--green,'g'
%          filename Ŀ��ͼ���ļ��������뱣֤��annotatedĿ¼��ramĿ¼������һ�µ�
%          num patch����������ڱ���ͼ���ʱ������patchͼ����
%          if_write �Ƿ񱣴�ͼ��1���棬0������
% ���������result - ���ͼ������
% ������ʷ�� v1.0 @2018-03-07 modified by Bohrium.Kwong

if nargin < 5
    showOrNot = 1;
    rgb = [224 255 255];
else
 switch Color
    case 'r'
        rgb = [255 0 0];
        dirname = 'lymphocyte';
    case 'g'
        rgb = [0 255 0];
        dirname = 'cancer cell';
    case 'y'
        rgb = [255 255 0];
        dirname = 'plasma cell';
 end
end
%rgb = [255 255 0];                                 % �߿���ɫ
lineSize = 1;                                      % �߿��С��ȡ1��2��3

if windSize > size(data,1) ||...
        windSize > size(data,2)
    %state = -1;                                     % ˵������̫��ͼ��̫С��û��Ҫ��ȡ
    disp('the window size is larger then image...');
    return;
end

[h,w,~]=size(data);
%�������ĵ�����cent_point�������Ͻ�����pointAll
y = round(cent_point(1,2));
x = round(cent_point(1,1));
pointAll = [y - windSize/2 ,x - windSize/2];
%��������ĵ���չ1/2�߳�������ͼ��ı߽磬����ͼ��߽������
if pointAll(1,1) < 1
    pointAll(1,1)=1;
elseif pointAll(1,1) > h - windSize - lineSize 
    pointAll(1,1)=h - windSize - lineSize;  
end
        
if pointAll(1,2) < 1
    pointAll(1,2)=1;
elseif pointAll(1,2) > w - windSize - lineSize 
    pointAll(1,2)=w - windSize - lineSize;  
end

result = data;
% ���������������Ե����14���أ�������Ҳ������ͼ��
if abs(x - w ) < w - windSize/2 || abs(x - h ) < h - windSize/2
  if size(data,3) == 3
    for k=1:3
       % for i=1:size(pointAll,1)   %���߿�˳��Ϊ�����������ԭ��
            i =1;
            result(pointAll(i,1),pointAll(i,2):pointAll(i,2)+windSize,k) = rgb(1,k);   
            result(pointAll(i,1):pointAll(i,1)+windSize,pointAll(i,2)+windSize,k) = rgb(1,k);
            result(pointAll(i,1)+windSize,pointAll(i,2):pointAll(i,2)+windSize,k) = rgb(1,k);  
            result(pointAll(i,1):pointAll(i,1)+windSize,pointAll(i,2),k) = rgb(1,k);  
            if lineSize == 2 || lineSize == 3
                result(pointAll(i,1)+1,pointAll(i,2):pointAll(i,2)+windSize,k) = rgb(1,k);  
                result(pointAll(i,1):pointAll(i,1)+windSize,pointAll(i,2)+windSize-1,k) = rgb(1,k);
                result(pointAll(i,1)+windSize-1,pointAll(i,2):pointAll(i,2)+windSize,k) = rgb(1,k);
                result(pointAll(i,1):pointAll(i,1)+windSize,pointAll(i,2)-1,k) = rgb(1,k);
                if lineSize == 3
                    result(pointAll(i,1)-1,pointAll(i,2):pointAll(i,2)+windSize,k) = rgb(1,k);   
                    result(pointAll(i,1):pointAll(i,1)+windSize,pointAll(i,2)+windSize+1,k) = rgb(1,k);
                    result(pointAll(i,1)+windSize+1,pointAll(i,2):pointAll(i,2)+windSize,k) = rgb(1,k);
                    result(pointAll(i,1):pointAll(i,1)+windSize,pointAll(i,2)+1,k) = rgb(1,k);
                end
            end
      %  end
    end
  end

 if if_write == 1
    imgdirname = fullfile('Cut Patches',First_d,'raw', filename);
    Img0 = imread(imgdirname);

%�����ļ�����'.'�����и�޳���׺
    img_reg = regexp(filename, '\.', 'split');
    save_filename = strcat(img_reg{1},'_',Color,'_',num2str(num),'.jpg');
    save_filename = fullfile('Cut Patches','result',First_d,dirname,save_filename);
%�����������Ͻ�����㱣��ͼ��
    imwrite(Img0(pointAll(1,1):pointAll(1,1)+windSize-1,pointAll(1,2):pointAll(1,2)+windSize-1,:),save_filename);
 end
end

if showOrNot == 1
    figure;
    imshow(result);
end