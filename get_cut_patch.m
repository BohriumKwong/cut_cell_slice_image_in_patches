% get_cut_patch('HE','annotated','raw');
function get_cut_patch(First_d,scond_a,scond_r)

dir_annotated = strcat(fullfile(pwd, 'Cut Patches',First_d,scond_a),'\');
%Img = imread(filename);
dir_raw = fullfile(pwd, 'Cut Patches',First_d,scond_r);
%����dir_raw�������ļ�����3��ʼ����Ϊ������./��../
list_raw=dir(fullfile(dir_raw));
fileNum=size(list_raw,1);
fp = fopen(strcat(First_d,'miss.txt'),'wt');
for k = 3:fileNum
    %��ͬһ���ļ�������dir_annotated�ҵ�ʱ�ſ�ʼ����
    if ~exist(strcat(dir_annotated,list_raw(k).name),'file')
        fprintf(fp, '%s \n',list_raw(k).name);
    else
       Img = imread(strcat(dir_annotated,list_raw(k).name)); 
       Img_mark = label_picture(Img,'r',list_raw(k).name,First_d);
       Img_mark = label_picture(Img_mark,'g',list_raw(k).name,First_d);
       Img_mark = label_picture(Img_mark,'y',list_raw(k).name,First_d);
       imwrite(Img_mark,fullfile(pwd, 'Cut Patches','result',First_d,'index',list_raw(k).name));
    end
end
fclose(fp);

%Img0 = imread(filename);
% figure;
% subplot(1, 2, 1); imshow(Img_mark, []); title('ģ���и�');
% subplot(1, 2, 2); imshow(Img0, []); title('ԭͼ��');
%imwrite(Img_mark,'18722__5121_29953.jpg')
% bwh_g = h >= 0.3 & h <= 0.43;
% bwh_r = h >= 0.87 & h <= 0.98;
%--------------------------------------------------------------%
function result = label_picture(Img,pc_color,filename,First_d)

% hsv�ռ����ֵ��ȡЧ������rgb�ã��ʸ������·���
r = Img(:,:,1);
g = Img(:,:,2);
b = Img(:,:,3);
switch pc_color
    case 'r'
        bw = r >= 150 & r <= 238 & g >=25 & g <= 75 & b > 33 & b < 87;
    case 'g'
        bw = r >= 12 & r <= 80 & g >=150 & g <= 212 & b > 66 & b < 119;
    case 'y'
        bw = r >= 200 & g >=188 & g <= 244 & b < 43;
end


[L, num] = bwlabel(bw);
% ����������ȡ
status = regionprops(L);
% ��������
cen_list = cat(1, status.Centroid);
% ������������
%cen_list = sortrows(cen_list, 2);

% filename2 = fullfile(pwd, 'Cut Patches','HE','raw', '18722__4353_23553.png');
% Img2 = imread(filename2);

for i = 1 : num
    cen = cen_list(i, :);
    Img = draw_rect_cen(Img,cen,28,0,pc_color,filename,i,First_d,1);
end
% figure(1);
% imshow(Img, []); title('ԭͼ����');
%hold on;
for i = 1 : num
    cen = cen_list(i, :);
    % plot(cen(1), cen(2), 'ro', 'MarkerFaceColor', 'r');
    %text(cen(1), cen(2), num2str(i), 'Color', 'g', 'FontSize', 10);
    Img =insertText(Img,[cen(1)-5 cen(2)-8],num2str(i),'FontSize', 9,'BoxOpacity', 0.0,'TextColor', 'black');
end
result = Img;
end
end
