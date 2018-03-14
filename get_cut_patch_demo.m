dir_name = 'HE';
Imgname = '18722__8193_17153.png';
filename = fullfile(pwd, 'Cut Patches',dir_name,'annotated', Imgname);
%18728__16129_2817
% HE 18722__5121_18433.png
Img = imread(filename);
filename = fullfile(pwd, 'Cut Patches',dir_name,'raw', Imgname);
Img0 = imread(filename);
Img_mark = label_picture(Img,'r',dir_name,Imgname);
Img_mark = label_picture(Img_mark,'g',dir_name,Imgname);
Img_mark = label_picture(Img_mark,'y',dir_name,Imgname);
imwrite(Img_mark,fullfile(pwd, 'Cut Patches','result',dir_name,'index',Imgname));
figure;
subplot(1, 3, 2); imshow(Img, []); title('标记图像');
subplot(1, 3, 3); imshow(Img_mark, []); title('模拟切割');
subplot(1, 3, 1); imshow(Img0, []); title('原图像');
%imwrite(Img_mark,'18722__5121_29953.jpg')
% bwh_g = h >= 0.3 & h <= 0.43;
% bwh_r = h >= 0.87 & h <= 0.98;
%--------------------------------------------------------------%
function result = label_picture(Img,pc_color,dir_name,Imgname)

r = Img(:,:,1);
g = Img(:,:,2);
b = Img(:,:,3);
switch pc_color
    case 'r'
        bw = r >= 150 & r <= 238 & g >=25 & g <= 75 & b > 33 & b < 87;
    case 'g'
        bw = r >= 12 & r <= 80 & g >=150 & g <= 212 & b > 66 & b < 119;
    case 'y'
        bw = r >= 147 & g >=158 & g <= 244 & b < 145;
end
[L, num] = bwlabel(bw);
% 区域属性提取
status = regionprops(L);
% 质心序列
cen_list = cat(1, status.Centroid);
% 从上向下排序
%cen_list = sortrows(cen_list, 2);


for i = 1 : num
    cen = cen_list(i, :);
    Img = draw_rect_cen(Img,cen,28,0,pc_color,Imgname,i,dir_name,1);
end
% figure(1);
% imshow(Img, []); title('原图像标记');
%hold on;
for i = 1 : num
    cen = cen_list(i, :);
    % plot(cen(1), cen(2), 'ro', 'MarkerFaceColor', 'r');
    %text(cen(1), cen(2), num2str(i), 'Color', 'g', 'FontSize', 10);
    Img =insertText(Img,[cen(1)-5 cen(2)-8],num2str(i),'FontSize', 9,'BoxOpacity', 0.0,'TextColor', 'black');
end
result = Img;
end
