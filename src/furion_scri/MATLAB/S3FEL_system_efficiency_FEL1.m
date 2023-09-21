function S3FEL_system_efficiency_FEL1()
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate the system efficiency of FEL-1
% 

%% ******************************************************************** %%
%                             M3c and M4c
format long
clear;clc;
Furion_physical_constants;
path_Str = Furion_filepath();
addpath(genpath(pwd));

%% *************************************************************** %%

wave_Lambda = linspace(0.2,3,3000)*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
gra_theta1 = 7e-3;
Grazing_str1 = Furion_grazing_compound(gra_theta1,phot_Energy,'B4C',path_Str,1); % M1,M2
gra_theta2 = 7.5e-3;
Grazing_str2 = Furion_grazing_compound(gra_theta2,phot_Energy,'B4C',path_Str,1); % M3,M4

gra_theta3 = 13e-3;
Grazing_str3 = Furion_grazing_compound(gra_theta3,phot_Energy,'B4C',path_Str,1); % M6
gra_theta4 = 10e-3;
Grazing_str4 = Furion_grazing_compound(gra_theta4,phot_Energy,'B4C',path_Str,1); % KB

%% *************************************************************** %%
%                            CDIʵ��վ                                    %
reflectivity1 = (Grazing_str1.R_intensity).^2.*(Grazing_str2.R_intensity)...
               .^2.*(Grazing_str4.R_intensity).^5;    % CDI
reflectivity2 = (Grazing_str1.R_intensity).^2.*(Grazing_str2.R_intensity)...
               .^2.*(Grazing_str3.R_intensity).*(Grazing_str4.R_intensity).^3;  % XPS
reflectivity3 = (Grazing_str1.R_intensity).^2.*(Grazing_str2.R_intensity)...
               .^2.*(Grazing_str4.R_intensity).^4;    % MDS 
reflectivity4 = (Grazing_str1.R_intensity).^2.*(Grazing_str2.R_intensity)...
               .^2.*(Grazing_str4.R_intensity).^3;    % RIXS             
subplot(1,2,1);
plot(wave_Lambda*1e9,reflectivity1)
hold on
plot(wave_Lambda*1e9,reflectivity2)
hold on
plot(wave_Lambda*1e9,reflectivity3)
hold on
plot(wave_Lambda*1e9,reflectivity4)
hold on
ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'���������ѧ����ʵ��վ','����AP-XPS�߻��о�ʵ��վ',...
        '��ά��ɢ��ϵͳ','����ǵ�����X����ɢ��ϵͳ'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
%% *************************************************************** %%
reflectivity1 = (Grazing_str1.R_intensity).^2.*(Grazing_str2.R_intensity)...
               .^2.*(Grazing_str4.R_intensity).^5.*Efficiency/100;    % CDI
reflectivity2 = (Grazing_str1.R_intensity).^2.*(Grazing_str2.R_intensity)...
               .^2.*(Grazing_str3.R_intensity).*(Grazing_str4.R_intensity).^3.*Efficiency/100;  % XPS
reflectivity3 = (Grazing_str1.R_intensity).^2.*(Grazing_str2.R_intensity)...
               .^2.*(Grazing_str4.R_intensity).^4.*Efficiency/100;    % MDS 
reflectivity4 = (Grazing_str1.R_intensity).^2.*(Grazing_str2.R_intensity)...
               .^2.*(Grazing_str4.R_intensity).^3.*Efficiency/100;    % RIXS             
subplot(1,2,2);
plot(wave_Lambda*1e9,reflectivity1)
hold on
plot(wave_Lambda*1e9,reflectivity2)
hold on
plot(wave_Lambda*1e9,reflectivity3)
hold on
plot(wave_Lambda*1e9,reflectivity4)
hold on
ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'���������ѧ����ʵ��վ','����AP-XPS�߻��о�ʵ��վ',...
        '��ά��ɢ��ϵͳ','����ǵ�����X����ɢ��ϵͳ'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);



