classdef Furion_paraboid_focus_Mirror<w_oe
    %������ѧԲ����  
    properties
        r; %Բ���������ʰ뾶  
        r2;
  
    end
    
    methods
        function obj=Furion_paraboid_focus_Mirror( beam_in,ds,di,chi,theta,surface,r2,grating)    
            obj = obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;  %��ʼ������  optical_element�Ĳ���      
           obj.r2=r2; %���
      
            obj.reflect;%�������          
        end
    end   
    
      methods %���ͷ���,׷��
        function tracing(obj)
           obj.g_mirror = g_Furion_paraboid_focus_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,obj.surface,obj.r2,obj.grating)   ;
        end
      end
    
end

