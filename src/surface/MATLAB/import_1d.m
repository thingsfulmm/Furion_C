classdef import_1d<handle   %����CSV�ļ�����Ϊdat��ʽ
     properties   
         meri;              %������������
         V;                 %��ʸ��������
         name;              %�ļ���
     end
     methods
             function  obj = import_1d(address) %����һά�������ݣ���2�У���ʽ��CSV ������Furion �� SRW ��һά���
                       data = importdata(address);                %����ԭʼ���ݣ���ʽ��CSV
                       [m,n] = size(data);                              %�õ����ݵ�����������
                       fid=fopen([address(1:end-3),'dat'],'wt');                   %����dat ����
                       for i = 1:m
                          for j= 1:n  
                              if j==n
                                 fprintf(fid,'%g\n',data(i,j));%ÿһ�У�����
                              else
                                 fprintf(fid,'%g\t',data(i,j));%����֮����tab������
                              end
                           end
                        end %�����ң����ϵ��£�һ����д����
                      fclose(fid);%�ر��ļ�
                      obj.meri = data(:,1);
                      obj.V    = data(:,2); 
                      obj.name = address(1:end-4);
             end
     end
        methods 
              function surface_plot(obj)
                  figure;plot(obj.meri,obj.V)%��ͼ��ʾ����
                  xlabel('L [m]','interpreter','latex','FontSize',18);
                  ylabel('Height error [m]','interpreter','latex','FontSize',22);
                  set(gcf,'Units','centimeters','Position',[10 10 25 10]);
                  set(gca,'TickLabelInterpreter','latex','fontsize',18,'linewidth',2);
                  set(get(gca,'Children'),'linewidth',2); 
              end               
        end    
         methods
          function save_to_shadow_2d(obj)%����Ϊshadow����ʶ����ļ���ʽ
              sag  = (-0.03:0.01:0.03)';   %��ʸ����
              data=repmat(obj.V,1,length(sag))';%������ά����
              Furion_save_to_shadow( obj.meri,sag,data,[obj.name,'_shadow.dat']);%����Ϊshadow�����Ǳ���ļ�
           end
     end 
               
 end

 