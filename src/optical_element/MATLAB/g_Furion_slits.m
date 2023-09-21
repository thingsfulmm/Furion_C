classdef g_Furion_slits<handle
    %����slits
    
    properties
        beam_out;%slits�������
    end
    
    methods 
        function obj = g_Furion_slits(beam_in,center_x,center_y,width,height) 
        n = beam_in.n;%���ߵ�����
        coord =zeros(1,n);%��ʼ���ڴ�
        for i = 1:n
            if abs(beam_in.XX(i)-center_x)<width/2 && abs(beam_in.YY(i)-center_y)<height/2%���
                coord(i)=i;
            end
       end
        k=find(coord);
        obj.beam_out = g_beam(beam_in.XX(k),beam_in.YY(k),beam_in.phi(k),beam_in.psi(k),beam_in.lambda);
        end
    end
    
end

