classdef F1F2 < handle
    %F0 �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��    
    properties 
      n_Refraction_str;   %�����ʽṹ 
      atomic_sym;         %Ԫ�ط���          �ַ�
      n;                  %���ݵ�����       ˫����
      ph_Energy;          %�������� ��λ eV ˫����
     formfactor_Str;%�ṹ����
    end
    
     methods              %��ʼ��
           function obj = F1F2(e_range,n,atomic_sym)%�������������Χ ev
               Furion_physical_constants; 
               obj.atomic_sym = atomic_sym;% 
               %************** �� �� �� ***************��ʼ��
                e=e_range(1):(e_range(2)-e_range(1))/(n-1):e_range(2);   %����qֵ������
                           %Ԫ�ز�ʸ��
                path_Str             =  Furion_filepath();
                obj.n                =  n;                       %Ԫ������
                obj.ph_Energy        =  e;               
                obj.n_Refraction_str =  Furion_complex_refraction(e,atomic_sym,path_Str);
                obj.formfactor_Str   =  Furion_formfactor_read_dis(e,atomic_sym,path_Str);
                %���㸴������ �������� delta beta chi �� n = 1 - delta + ibeta ��                    
            end %���÷�Χ�͵���
     end  
     
     methods %�� q --> f1 ͼ
       function plot_f1(obj)
           f1=obj.formfactor_Str.f1;
            plot(log10(obj.ph_Energy),f1,'LineWidth',2,'color','red');%��ͼ ������ɢ��ʸ���������꣬ԭ����״����
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('eV ','interpreter','latex','FontSize',16);
            ylabel('$f_1$ [electron units]','interpreter','latex','FontSize',16);
            title(obj.atomic_sym);
        end
     end  
     
     methods %�� q --> f2 ͼ
       function plot_f2(obj)
           f2= obj.formfactor_Str.f2;
            plot(log10(obj.ph_Energy),f2,'LineWidth',2,'color','red');%��ͼ ������ɢ��ʸ���������꣬ԭ����״����
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('eV [log10] ','interpreter','latex','FontSize',16);
            ylabel('$f_2$ [electron units][linear]','interpreter','latex','FontSize',16);
            title(obj.atomic_sym);
        end
     end  
     
      methods %�� q -->delta ͼ
       function plot_delta(obj)        
            delta = obj.n_Refraction_str.delta;%            
            plot(log10(obj.ph_Energy),delta','LineWidth',2,'color','red');%��ͼ ������ɢ��ʸ���������꣬ԭ����״����
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('eV [log10] ','interpreter','latex','FontSize',16);
            ylabel('$\delta$ [linear]','interpreter','latex','FontSize',16);
            title([obj.atomic_sym ,'\delta']);                              %���ñ���
        end
      end  
     
      methods %�� q --> beta ͼ
       function plot_beta(obj)
            beta =  obj.n_Refraction_str.beta;
            plot(log10(obj.ph_Energy),beta','LineWidth',2,'color','red');%��ͼ ������ɢ��ʸ���������꣬ԭ����״����
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('eV [log10] ','interpreter','latex','FontSize',16);
            ylabel('$\beta$ [linear]','interpreter','latex','FontSize',16);
            title([obj.atomic_sym ,'\beta']);  
        end
     end 
end

