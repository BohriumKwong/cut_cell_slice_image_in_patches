% ���ű�ֱ�����ڿ����ҳ�����ָ����Ŀ¼��(��Ŀ¼A��Ŀ¼B)��BĿ¼���ļ���AĿ¼������ͬ���ļ�
% �����ҵĽ�����浽miss.txt

dir_raw ='Cut_Patches\HE\raw\';
dir_annotated ='Cut_Patches\HE\annotated\';
list_raw=dir(fullfile(dir_raw));
fileNum=size(list_raw,1);
%s ='��rawĿ¼���ļ��޷���annotated�ҵ�ƥ��';
fp = fopen('miss.txt','wt');
for i = 3:fileNum
    if ~exist(strcat(dir_annotated ,list_raw(i).name),'file')
        %s = char(s,list(i).name);
        fprintf(fp, '%s \n',list_raw(i).name);
    end
end
fclose(fp);
