%ģ������������������ Shadow��Srw��Furionʹ��
h_Error_rms = 0.8e-9;%�߶ȱ�׼��
s_Error_rms = 80e-9;%б�ʱ�׼��
n_Upper = 16 ;%�������Ƶ��
b = random_to_dat(h_Error_rms,s_Error_rms,n_Upper,'G');%��������������
b.save_to_furion_and_srw_1d();    %�����dat��ʽ�����Ը�Furion ��srw ʹ��
b.save_to_srw_2d();               %����Ϊdat��ʽ�����Ա�srw�����ȡ
b.save_to_shadow_2d();            %����Ϊdat��ʽ�����Ա�shadow�����ȡ