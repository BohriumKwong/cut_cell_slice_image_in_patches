% 本脚本直接用于快速找出两个指定的目录下(如目录A和目录B)，B目录的文件在A目录不存在同名文件
% 将查找的结果保存到miss.txt

dir_raw ='Cut_Patches\HE\raw\';
dir_annotated ='Cut_Patches\HE\annotated\';
list_raw=dir(fullfile(dir_raw));
fileNum=size(list_raw,1);
%s ='在raw目录的文件无法在annotated找到匹配';
fp = fopen('miss.txt','wt');
for i = 3:fileNum
    if ~exist(strcat(dir_annotated ,list_raw(i).name),'file')
        %s = char(s,list(i).name);
        fprintf(fp, '%s \n',list_raw(i).name);
    end
end
fclose(fp);
