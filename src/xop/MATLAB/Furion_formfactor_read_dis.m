function formfactor_Str = Furion_formfactor_read_dis(phot_Energy1,atomic_sym,path_Str)
%% ************************************************************** %%
format long                                                        %��ʾ��С��λ��
%% ************************************************************** %%
%         Read the dispersion part f1 and f2 of form factor

atomic_sym = lower(atomic_sym);
file_f1_f2 = [atomic_sym,'.nff'];%�ļ���

[pho_energy,data_f1,data_f2] = textread([path_Str.path_formfactor,file_f1_f2],'%f %f %f','delimiter', ' ','headerlines', 1);
%��ȡ�ļ�

form_fa_f1 = interp1(pho_energy,data_f1,phot_Energy1);
form_fa_f2 = interp1(pho_energy,data_f2,phot_Energy1);%��ֵ

formfactor_Str.f1 = form_fa_f1; %�ṹ����f1
formfactor_Str.f2 = form_fa_f2; %�ṹ����f2

end
