function [l_Mirro,f_Error,s_Error] = Furion_figure_error(h_Error_rms,s_Error_rms,n_Upper)%����������������
%[out_field,fig_error,phase_error] = Furion_figure_error(X,Y,in_field,wave_Lambda,h_error,s_error,theta,N_ferror)
% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
% This function is used to generate the figure error of Mirrors for given height
% error, slope error, and spatial frequency.
% Input:
%       h_Error_rms: rms of height error [m]
%       s_Error_rms: rms of slope error [rad]
%       n_Upper:  the maximum spatial frequency [int] 
% Output:
%       l_Mirro:  array of mirror length
%       f_Error:  array of figure error
%       s_Error�� array of slope error

%% ******************************************************************** %%
format long       %��ʾ��ʽС������汣����λ
delta_L = 1.0;    % ��ѧԪ�������緽��ĳߴ�
l_Mirro = linspace(-delta_L/2,delta_L/2,100);  %���緽������
n_Lower = round(s_Error_rms*delta_L/(2*pi*h_Error_rms));%��Ƶ
ran_pha = rand(1,n_Upper)*2*pi;
b_coeff = h_Error_rms./(2.2e-10*n_Lower.^(-2.0));
f_Error = 0;%��ʼ�ĸ߶����
for k = n_Lower:n_Upper%Ƶ�ʷ�Χ
    bn = b_coeff*2.1e-10*k^(-2.0);
    f_Error = f_Error + bn*cos(2*pi*k/delta_L*l_Mirro+ran_pha(k));
end

s_Error = [diff(f_Error)./diff(l_Mirro),s_Error_rms];%б�����Ϊ�߶�����һ�׵���


