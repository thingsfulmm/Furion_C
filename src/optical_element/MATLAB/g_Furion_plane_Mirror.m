classdef  g_Furion_plane_Mirror < g_oe%׷��phaseת���ɽǶ�
  properties
  
  end
methods
function obj = g_Furion_plane_Mirror( beam_in,ds,di,chi,theta,surface,grating)   
         obj=obj@g_oe( beam_in,ds,di,chi,theta,surface,grating) ;%�������������    
         obj.reflect(beam_in,ds,di,chi,theta);%���������
end
end
end
