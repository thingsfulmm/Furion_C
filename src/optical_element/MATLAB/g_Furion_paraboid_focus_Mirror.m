classdef  g_Furion_paraboid_focus_Mirror < g_Furion_cyliner_parabolic_focus_Mirror%׷��phaseת���ɽǶ�
  properties 
    
  end
methods
function obj = g_Furion_paraboid_focus_Mirror( beam_in,ds,di,chi,theta,surface,r2,grating)   
    obj=obj@g_Furion_cyliner_parabolic_focus_Mirror( beam_in,ds,di,chi,theta,surface,r2,grating) ;%�������������   
   
end
end

methods%����ת��Ϊcenter�������
    function set_center(obj, beam_in,ds,di,chi,theta,surface,r2,grating)
        obj.center =g_paraboid_focus( beam_in,ds,di,chi,theta,surface,r2,grating)  ;
    end
end
end
