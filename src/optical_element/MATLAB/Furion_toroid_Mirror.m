classdef Furion_toroid_Mirror<w_oe
    %������ѧԲ����  
    properties
        R1; %Բ���������ʰ뾶  
        R2;
        rho1;
        rho2;
    end
    
    methods
        function obj=Furion_toroid_Mirror( beam_in,ds,di,chi,theta,surface,R1,R2,rho1,rho2,grating)  
            obj = obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;  %��ʼ������  optical_element�Ĳ���      
            obj.R1 =R1;
            obj.R2=R2;
            obj.rho1=rho1;
            obj.rho2 =rho2;
            obj.reflect;%�������          
        end
    end   
    
      methods %��ѧ׷��
        function tracing(obj)
           obj.g_mirror =  g_Furion_toroid_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,no_surfe(),obj.R1,obj.R2,obj.rho1,obj.rho2,grating)  ;
          
        end
      end
    
end

