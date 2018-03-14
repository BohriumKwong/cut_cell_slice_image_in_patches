function result=draw_rect_cen(data,cent_point,windSize,showOrNot,Color,filename,num,First_d,if_write)
% 函数调用：[state,result]=draw_rect(data,pointAll,windSize,showOrNot)
% 函数功能：在图像画个正方形框
% 函数输入：data为原始的大图，可为灰度图，可为彩色图
%          cent_point 框的中心在大图中的坐标(每行代表一个坐标)，
%          windSize 框的边长大小
%          showOrNot 是否要显示,默认为显示出来
%          Color 需要提取的标记颜色：lymphocyte--red,'r'
%                                   plasma cell--yellow,'y'
%                                   cancer cell--green,'g'
%          filename 目标图像文件名，必须保证在annotated目录和ram目录两者是一致的
%          num patch标记数，用于保存图像的时候区分patch图像名
%          if_write 是否保存图像，1保存，0不保存
% 函数输出：result - 结果图像数据
% 函数历史： v1.0 @2018-03-07 modified by Bohrium.Kwong

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
%rgb = [255 255 0];                                 % 边框颜色
lineSize = 1;                                      % 边框大小，取1，2，3

if windSize > size(data,1) ||...
        windSize > size(data,2)
    %state = -1;                                     % 说明窗口太大，图像太小，没必要获取
    disp('the window size is larger then image...');
    return;
end

[h,w,~]=size(data);
%根据中心点坐标cent_point计算左上角坐标pointAll
y = round(cent_point(1,2));
x = round(cent_point(1,1));
pointAll = [y - windSize/2 ,x - windSize/2];
%如果从中心点扩展1/2边长超出了图像的边界，就以图像边界做起点
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
% 方框中心坐标离边缘不足14像素，不画框，也不保存图像
if abs(x - w ) < w - windSize/2 || abs(x - h ) < h - windSize/2
  if size(data,3) == 3
    for k=1:3
       % for i=1:size(pointAll,1)   %画边框顺序为：上右下左的原则
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

%根据文件名以'.'进行切割，剔除后缀
    img_reg = regexp(filename, '\.', 'split');
    save_filename = strcat(img_reg{1},'_',Color,'_',num2str(num),'.jpg');
    save_filename = fullfile('Cut Patches','result',First_d,dirname,save_filename);
%根据区域左上角坐标点保存图像
    imwrite(Img0(pointAll(1,1):pointAll(1,1)+windSize-1,pointAll(1,2):pointAll(1,2)+windSize-1,:),save_filename);
 end
end

if showOrNot == 1
    figure;
    imshow(result);
end