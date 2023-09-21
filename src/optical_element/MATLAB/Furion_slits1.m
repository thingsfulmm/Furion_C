classdef Furion_slits1<handle
    %����slits
    
    properties
        beam_out;%slits�������
    end
    
    methods 
        function obj = Furion_slits1(beam_in,center_x,center_y,width,height) 
              X =beam_in.X;
              Y =beam_in.Y;
              V0= beam_in.field;              
              slit_X = rectpuls(X-center_x,width);%
              slit_Y = rectpuls(Y-center_y,height);         
              V =V0.*slit_X.*slit_Y;
             obj.beam_out = beam(X,Y,V,beam_in.wavelength);%��������
        end
    end
    
end

