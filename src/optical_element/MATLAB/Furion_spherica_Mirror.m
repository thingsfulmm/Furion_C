classdef Furion_spherica_Mirror<w_oe
    %������ѧԲ����  
    properties
        r; %Բ���������ʰ뾶     
    end
    
    methods
        function obj=Furion_spherica_Mirror( beam_in,ds,di,chi,theta,surface,r,grating)   
            obj = obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;  %��ʼ������  optical_element�Ĳ���      
            obj.r=r;%��ʼ���뾶     
        
            obj.reflect;%�������          
        end
    end   
    
      methods %��ѧ׷��
        function tracing(obj)
           obj.g_mirror = g_Furion_spherical_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,no_surfe(),obj.r,obj.grating);
        end
      end
    
end

