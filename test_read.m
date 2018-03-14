filename = fullfile(pwd, 'Cut_Patches','HE','annotated', '18722__5121_29953.png');
Img = imread(filename);
%figure; imshow(Img, []); title('原图像');
% 颜色空间转换
hsv = rgb2hsv(Img);
h = hsv(:,:,1); %h = mat2gray(h);
s = hsv(:,:,2); %s = mat2gray(s);
v = hsv(:,:,3); %v = mat2gray(v);

r = Img(:,:,1);
g = Img(:,:,2);
b = Img(:,:,3);

% figure(1);
% subplot(2, 2, 1); imshow(Img, []); title('原图像');
% subplot(2, 2, 2); imshow(h, []); title('h图像');
% subplot(2, 2, 3); imshow(s, []); title('s图像');
% subplot(2, 2, 4); imshow(v, []); title('v图像');

figure(2);
subplot(2, 2, 1); imshow(Img, []); title('原图像');
subplot(2, 2, 2); imshow(r, []); title('r图像');
subplot(2, 2, 3); imshow(g, []); title('g图像');
subplot(2, 2, 4); imshow(b, []); title('b图像');


bwh_g = h >= 0.3 & h <= 0.43;
bws_g = s >= 0.70;
bwh_r = h >= 0.947 & h <= 0.99;
bws_r = s >= 0.76  & s <= 0.88;
bwh_y = h >= 0.15 & h <= 0.16;
bws_y = s >= 0.80;

bwh_r = bwh_r & bws_r;
bwh_g = bwh_g & bws_g;
bwh_y = bwh_y & bws_y;

bw_r = r >= 150 & r <= 238 & g >=25 & g <= 75 & b > 33 & b < 87;
bw_g = r >= 12 & r <= 80 & g >=150 & g <= 212 & b > 66 & b < 119;
bw_y = r >= 147 & g >=150 & g <= 244 & b < 145;


% figure(3);
% subplot(2, 2, 1); imshow(Img, []); title('原图像');
% subplot(2, 2, 2); imshow(bwh_r, []); title('hsv提取红色');
% subplot(2, 2, 3); imshow(bwh_g, []); title('hsv提取绿色');
% subplot(2, 2, 4); imshow(bwh_y, []); title('hsv提取黄色');

figure(4);
subplot(2, 2, 1); imshow(Img, []); title('原图像');
subplot(2, 2, 2); imshow(bw_r, []); title('rgb提取红色');
subplot(2, 2, 3); imshow(bw_g, []); title('rgb提取绿色');
subplot(2, 2, 4); imshow(bw_y, []); title('rgb提取黄色');

[L, num] = bwlabel(bw_y);
% 区域属性提取
status = regionprops(L);
% 质心序列
cen_list = cat(1, status.Centroid);
% 从上向下排序
%cen_list = sortrows(cen_list, 2);

% filename2 = fullfile(pwd, 'Cut Patches','HE','raw', '18722__4353_23553.png');
% Img2 = imread(filename2);
% 
% for i = 1 : num
%     cen = cen_list(i, :);
%     [~,Img] = draw_rect_cen(Img,cen,20,0,'g');
% end
% 
% % figure(1);
% % imshow(Img, []); title('原图像标记');
% %hold on;
% for i = 1 : num
%     cen = cen_list(i, :);
%     % plot(cen(1), cen(2), 'ro', 'MarkerFaceColor', 'r');
%     %text(cen(1), cen(2), num2str(i), 'Color', 'g', 'FontSize', 10);
%     Img =insertText(Img,[cen(1)-5 cen(2)-8],num2str(i),'FontSize', 10,'BoxOpacity', 0.0,'TextColor', 'black');
% end
% figure(1);
% imshow(Img, []); title('原图像标记');
% %hold off;
% imwrite(Img,'test.jpg')
%saveas(figure(1),'test','jpg')
%subplot(1, 2, 2); imshow(Img2, []); title('标记图像');
