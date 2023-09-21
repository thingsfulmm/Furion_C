classdef import_2d_from_xu<no_surfe
    properties   
%          meri_2d;
%          sag_2d;
%          V_2d;
         name;
         meri_1d;
         sag_1d;
    end
    methods
        function obj = import_2d_from_xu(address,ratio)
            obj.name = address(1:end-4);
            data_1 = importdata(address)/1000;%����ԭʼ����
            X=data_1(:,1);%��һ�У�X
            Y=data_1(:,2);%�ڶ��У�Y
            Z=data_1(:,3);%�����У�Z
            
            %------------��չ����----------------
            data_2=[-X Y Z];
            data_3=[-X -Y Z];
            data_4=[X -Y Z];
            data_merge= [data_1 ;data_2 ;data_3 ;data_4];%��������չ���ĸ�����     
            
            %-----------------�����ݽ��в�ֵ------------------------------
            X1=data_merge(:,1);
            Y1=data_merge(:,2);
            Z1=data_merge(:,3);
            F = scatteredInterpolant(X1,Y1,Z1);
            F.Method = 'linear';
            y  =-150e-3:0.5e-3:150e-3;
            x =-15e-3:0.2e-3:15e-3;
            obj.meri_1d =y;
            obj.sag_1d =x;
            [Xd,Yd]=meshgrid(x,y);
            data1 = F(Xd,Yd);
            obj.meri_X = Xd;
            obj.sag_Y  = Yd;
            obj.V    = data1*ratio;
%             data=data1*ratio;%ratio ����б�����
%             [m,n] = size(data);
%             
%             fid=fopen([address(1:end-3),'100slpeFurion','.dat'],'wt');%���浽Furion����ʶ���ģʽ
%                 for i = 1:m
%                     for j= 1:n  
%                       if j==n
%                         fprintf(fid,'%g\n',data(i,j));
%                        else
%                        fprintf(fid,'%g\t',data(i,j));
%                       end
%                     end
%                 end
%             fclose(fid);
%         end
    end
    end
%     methods
%         function   surface_plot(obj)  %����ͼ��          
%             mesh(obj.meri_2d,obj.sag_2d,obj.V_2d); 
%             view(3);
%             set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',2);
%             xlabel('X','interpreter','latex','FontSize',22);
%             ylabel('Y','interpreter','latex','FontSize',22);
%             zlabel('Z','interpreter','latex','FontSize',22);
%         end
%     end
    
    methods
        function save_to_shadow(obj)
            fid=fopen([obj.name,'_shadow.dat'],'wt');
            y = obj.meri_1d;
            x = obj.sag_1d;
            fprintf(fid,'%g',length(x));% ��ʾ�к������� ��һ�У�
            fprintf(fid,'%g\n ',length(y));
            

           for i=1:length(y)-1
             fprintf(fid,'%g ',y(i));
           end
           fprintf(fid,'%g\n',y(end));  % ��ʾ�������ꣻ
           data =obj.V;
           data2 = [x' data']; % ����ʸ����󶨵����������ϣ�
             [m,n] = size(data2);
                for i = 1:m
                    for j = 1:n  
                      if j == n
                        fprintf(fid,'%g\n',data2(i,j));
                      else
                        fprintf(fid,'%g  ',data2(i,j));
                      end
                    end
                end
           fclose(fid);
        end
    end
%     
%     methods
%         function save_to_srw(obj)%����Ϊsrw����ʶ���ģʽ
%             x=obj.sag_1d; %��ʸ����
%             y=obj.meri_1d;% ��������
%             data = obj.V_2d;% ��ά����
%             fid=fopen([obj.name,'_SRW.dat'],'wt');%���ļ�
%                 for i=1:length(x)-1                  %����X
%                     fprintf(fid,'%g\t ',x(i));
%                 end
%                 fprintf(fid,'%g\n',x(end));  % ��ʾ�������ꣻ
% 
%                 data2 = [y' data]; % ����������󶨵����������ϣ�
%                 [m,n] = size(data2);%������������ �Իس����У���
%                 for i = 1:m
%                     for j = 1:n  
%                       if j == n
%                         fprintf(fid,'%g\n',data2(i,j));
%                       else
%                         fprintf(fid,'%g\t',data2(i,j));
%                       end
%                     end
%                 end
%                 fclose(fid);
%         end
%     end
end