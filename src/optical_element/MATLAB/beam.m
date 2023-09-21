classdef beam <handle 
    %������ѧ�еĹ���    
    properties   
        wavelength;     % ��������λ           [m]
        X;              % �������� X����
        Y;              % �������� Y����
        field;          % ������ ���� ��ά����        
        N;              % ����ĳ��� ��λ ��ĸ���
        phase_field;    % ��λ���ֲ�
        XX;%              ɢ�㻯
         YY;%ɢ�㻯
%         phi;psi;n;
     
    end
    
    methods
        function obj = beam(X,Y,field,wavelength)
            obj.X =X;
            obj.Y =Y;
            obj.field =field;
            obj.wavelength =wavelength; 
            obj.N=size(X,1);                            %��������X�����������з��򣩷����ά����
            %obj.path();
        end
    end    
    
   methods  % plot ǿ�ȷֲ�ͼ����λ�ֲ�ͼ  ���� distanceΪ���� ��λ [m]
        function  detector_field(obj,distance)                  
            addpath(genpath('.\display'));                            %��� ��ʾ��άǿ�Ⱥ�����·��
             if (nargin<2)                                            %�������С��2����ֱ�� ��ͼ
                  Furion_intensity_detector(obj.X,obj.Y,obj.field,0); %��ͼ���� ���� X ���� Y ���� field ������ 
                  Furion_phase_detector(obj.X,obj.Y,obj.field,2);  
             else
                  bs=obj.translation(distance);                        %���2���������Ƚ����ߴ���һ�ξ��� distance��
                  Furion_intensity_detector(bs.X,bs.Y,bs.field,0);     %Ȼ����ͼ��ʾǿ�ȷֲ�
                  Furion_phase_detector(obj.X,obj.Y,obj.field,1);      %��ͼ��ʾ��λ�ֲ�
             end          
        end
   end  
      
   methods % �����ߴ���һ�ξ���   distance ���� ��λ[m]  
        function  beam_tanslated = translation(obj,distance)       
             flag = 2;%ѡ�񴫲���
             L = max(obj.X(1,:))-min(obj.X(1,:));%�ռ�����ĳߴ�
             if flag ==1                 
                 out_Field = Furion_fresnel_spatialh (obj.X,obj.Y,obj.field,obj.wavelength,distance); 
                 %�����������ӡ�ʵ��ռ����
             elseif flag ==2
                 out_Field = Furion_fresnel_spectralh (obj.N,1/L,obj.field,obj.wavelength,distance);
                 %�����������ӣ�Ƶ��ռ����
             elseif flag == 3
                 out_Field = Furion_angular_spectrum (obj.N,1/L,obj.field,obj.wavelength,distance);
             else
                 out_Field = fresnel_propagation_mono_2D(obj.field,L,L,obj.wavelength,distance) ;
             end
                  beam_tanslated = beam(obj.X,obj.Y,out_Field,obj.wavelength);     %�����µĹ���       
        end
   end
       
    methods%�ز���  %������ƽ�澵�����澵  %���²��� L���²����ĳߴ��С ��λ [m]
        function  beam_=resize1(obj,L)   
           x = linspace(-L/2,L/2,obj.N);                                        %���²���x�᷽��
            y = x';                                                             %���²���Y�᷽��
            [X_r,Y_r] = meshgrid(x,y);   
            %�������²����������
 
            
            F = scatteredInterpolant(obj.X(:),obj.Y(:),obj.field(:),'linear');  %ɢ���ֵ  һά����
            Field_new = F(X_r(:),Y_r(:));                                       %��ֵ�õ��µĲ���
            Field_new_1 =reshape(Field_new,obj.N,obj.N);                        %����һάת��Ϊ��ά
           beam_ = beam(X_r,Y_r,Field_new_1,obj.wavelength);                    %�����µĹ���         
        end
    end
    
     methods%�ز���  %������ƽ�澵�����澵  %���²��� L���²����ĳߴ��С ��λ [m]
        function  beam_=resize2(obj,L,N)   %   �ı�size�ͳ�������
           x = linspace(-L/2,L/2,N);                                        %���²���x�᷽��
            y = x';                                                             %���²���Y�᷽��
            [X_r,Y_r] = meshgrid(x,y);   
            %�������²����������
 
            
            F = scatteredInterpolant(obj.X(:),obj.Y(:),obj.field(:),'linear');  %ɢ���ֵ  һά����
            Field_new = F(X_r(:),Y_r(:));                                       %��ֵ�õ��µĲ���
            Field_new_1 =reshape(Field_new,N,N);                        %����һάת��Ϊ��ά
           beam_ = beam(X_r,Y_r,Field_new_1,obj.wavelength);                    %�����µĹ���         
        end
     end
    
         methods%�ز���  %������ƽ�澵�����澵  %���²��� L���²����ĳߴ��С ��λ [m]
        function  beam_=resize3(obj,Lx, Ly,N)   %   �ı�size�ͳ�������
           x = linspace(-Lx/2,Lx/2,N);                                        %���²���x�᷽��
            y = linspace(-Ly/2, Ly/2, N)';                                                             %���²���Y�᷽��
            [X_r,Y_r] = meshgrid(x,y);   
            %�������²����������
 
            
            F = interp2(obj.X,obj.Y,obj.field,X_r,Y_r,'cubic',0);  %ɢ���ֵ  һά����
            %Field_new = F(X_r(:),Y_r(:));                                       %��ֵ�õ��µĲ���
            %Field_new_1 =reshape(Field_new,N,N);                        %����һάת��Ϊ��ά
           beam_ = beam(X_r,Y_r,F,obj.wavelength);                    %�����µĹ���         
        end
    end
  
methods       %����������ܹ���
    function p = power(obj)
          x = obj.X(1,:);
          y = obj.Y(:,1);
          p = trapz(y,trapz(x,abs(obj.field).^2,2));
        % p= sum(sum(abs(obj.field).^2))*dx*dy;%�����ƽ�����
    end
end

end

