function path_Str = Furion_filepath()
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function returns the structure of file paths.
%
% Output:
%      path_Str
%   
%% ************************************************************** %%

inter_name  = dir;                           %�ļ�����Ϣ�ṹ��
path_script = inter_name.folder;             %�ļ������ƺ�
inter_name  = strsplit(path_script,'\');     %
path_inter  = [];
for k = 1:(length(inter_name)-1)
    path_inter  = [path_inter,cell2mat(inter_name(k)),'\'];
end

%% ************************************************************** %%
%                  add paths in the following section

path_formfactor  =  [path_inter,'database\f0_f1f2\'];            %��״����
path_datax = [path_inter,'database\'];                           %���ݿ�

%% ************************************************************** %%

path_Str.path_script = path_script;                           % xop �ļ���                   
path_Str.path_formfactor = path_formfactor;                   % �ṹ�����ļ���
path_Str.path_datax = path_datax;                             % ���ݿ��ļ���