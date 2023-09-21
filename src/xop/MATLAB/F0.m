classdef F0 < handle
    %F0 �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��    
     properties
      f0;          %�ṹ����
      f1;f2;       %�ṹ����
      q;           %ɢ��ʸ��
      atomic_sym;  %Ԫ�ط���
      n;           %���ݵ�����
      ph_Energy;   %��������
    end
    
     methods         %��ʼ��
      function obj = F0(q_range,n)
            q=q_range(1):(q_range(2)-q_range(1))/(n-1):q_range(2);   %����qֵ������
            obj.q=q;                       %Ԫ�ز�ʸ��
            obj.n=n;                       %Ԫ������
            obj.ph_Energy = 12.398./(sind(90)./q);
       end %���÷�Χ�͵���
     end
    
     methods      %��ͼԪ�ص���״����
       function   obj=element_F(obj,atomic_sym)%
           
            bragg_Str.theta_Bragg = 90;                         %���ò����񲨳�    
            %******************* �� �� ��***********************
            F0 = zeros(1,obj.n);    
            F1 = zeros(1,obj.n); 
            F2 = zeros(1,obj.n); %�����ʼ�ڴ�
            ph_Energy1 = zeros(1,obj.n); 
            %************** �� �� �� *************************** 
            
            path_Str = Furion_filepath();                        %����·��
            
            for i = 1:obj.n                                         %������
             bragg_Str.wave_Lambda = 1/obj.q(i);  %���벨��
             bragg_Str.phot_Energy = obj.ph_Energy(i); %������Ӧ�Ĺ�������
             formfactor_Str = Furion_formfactor_read(bragg_Str,atomic_sym,path_Str);%������״���ӣ����壩
             
             F0(i) = formfactor_Str.f0;%��״���� f0
             F1(i) = formfactor_Str.f1;
             F2(i) = formfactor_Str.f2;
             ph_Energy1(i) = bragg_Str.phot_Energy; 
            end
            obj.f0 = F0;  
            obj.f1 = F1;
            obj.f2 = F2;
            obj.ph_Energy = ph_Energy1;
        end
     end
    
     methods      %���������״����
        function obj=compound_F(obj,compound_Sym)
            F0=zeros(1,obj.n);            
            a=strsplit(compound_Sym);              %�ָ��ַ��� ���确H_2 O��->['H_2','O']
            for i = 1:length(a)
                b = strsplit(a{i},'_');            %�ڴηָ� ��H_2��->['H','2']
                if length(b)==2
                obj.element_F(b{1});              %����Ԫ�ص�f0��״����
                F0=F0+obj.f0*str2double(b{2});
                else
                    obj.element_F(b{1}); 
                    F0=F0+obj.f0;
                end
            end
            obj.f0 =F0;                             %����Ԫ��f0�ĵ��Ӿ����ܵķ��ӵ���״����
        end
     end
    
     methods %�� q --> f0 ͼ
       function plot_f(obj,atomic_sym)
            plot(obj.q/(1e10),obj.f0,'LineWidth',2,'color','red');%��ͼ ������ɢ��ʸ���������꣬ԭ����״����
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('q [$\frac{sin\theta}{\lambda}$][$A^{-1}$]','interpreter','latex','FontSize',16);
            ylabel('$f_0$ [electron units]','interpreter','latex','FontSize',16);
            title(atomic_sym);
        end
     end  
end

