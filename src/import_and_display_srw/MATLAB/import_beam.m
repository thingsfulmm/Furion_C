classdef import_beam<handle
    %IMPORT_BEAM �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��    
    properties
        X;% X�����
        Y;% Y�����
        Z_intensity;   %����㴦��ǿ��
        Z_phase;       %����㴦����λ
        Nx;            %�����X���������
        Ny;            %�����Y���������
        scale_x;       %����ϵ��
        scale_y;       %����ϵ��
        field;         %����㴦�Ĺ�ĸ�����ǿ
    end 
    
    methods
        function obj =import_beam(intensity_address)
            intensity_data = dlmread(intensity_address);% ���ļ��е��� .data����
            data =intensity_data;                       % 
            row=data(:,1);%�к�
            colum=data(:,2);%�к�
            z=data(:,3);%����
            N_colum= sum(row(:)==0);%����
            N_row = sum(colum(:)==0);%����
            obj.X = reshape(colum,[N_colum,N_row])';
            obj.Y = reshape(row,[N_colum,N_row])';
            obj.Z_intensity = reshape(z,[N_colum,N_row])';
            obj.Ny = N_colum;
            obj.Nx = N_row ;
            
        end        
    end
    
    methods
        function import_phase(obj,phase_address)   %���ļ��е�����λ����
            phase_data = dlmread(phase_address);  
            data =phase_data;
            row=data(:,1);%�к�
            colum=data(:,2);%�к�
            z=data(:,3);%����
            N_colum= sum(row(:)==0);%����
            N_row = sum(colum(:)==0);%����
            %obj.X = reshape(colum,[N_colum,N_row])';
            %obj.Y = reshape(row,[N_colum,N_row])';
            obj.Z_phase = reshape(z,[N_colum,N_row])';
            obj.field = sqrt(obj.Z_intensity).*exp(1i.*obj.Z_phase) ;
        end        
    end    
  
    
    methods
        function coordinate_transform(obj,x_max,x_min,y_max,y_min)%����ת����SRW�����������Ǿ�����Ҫ����Ӧ��X��Y�����Ӧ��
                 length_X = max(max(obj.X));
                 length_Y = max(max(obj.Y));
                 obj.scale_x =(x_max - x_min)./length_X;
                 obj.scale_y =(y_max - y_min)./length_Y;
                 obj.X    = (obj.X.*obj.scale_x - x_max);
                 obj.Y    = (obj.Y.*obj.scale_y - y_max);
        end        
    end
    
    methods
        function coordinate_diffraction(obj,shift_X,shift_Y)%���������ƫ��λ��
             obj.Z_intensity = circshift(obj.Z_intensity,round(shift_X/obj.scale_x),2) ;
             obj.Z_intensity = circshift(obj.Z_intensity,round(shift_Y/obj.scale_y),1) ;   
             obj.Z_phase     = circshift(obj.Z_phase,round(shift_X/obj.scale_x),2) ;
             obj.Z_phase     = circshift(obj.Z_phase,round(shift_Y/obj.scale_y),1) ; 
             obj.field = circshift(obj.field,round(shift_X/obj.scale_x),2) ;
             obj.field = circshift(obj.field,round(shift_Y/obj.scale_y),1) ;
        end        
    end    
    
     methods
        function phase_plot(obj)      %������λͼ
             Furion_phase_detector(obj.X*1e-6,obj.Y*1e-6,obj.field,1);
        end        
     end  
    
    methods
        function intensity_plot(obj)  %����ǿ��ͼ
            Furion_intensity_detector(obj.X*1e-6,obj.Y*1e-6,obj.field,1);          
        end        
    end
    
    methods         %����
        function p = power(obj,dx,dy)
            p = sum(sum(obj.Z_intensity))*dx*dy;%�����ܵĹ���
        end
    end
end

