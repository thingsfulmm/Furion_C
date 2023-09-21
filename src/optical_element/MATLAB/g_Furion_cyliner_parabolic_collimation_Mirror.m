classdef  g_Furion_cyliner_parabolic_collimation_Mirror < g_oe%׷��phaseת���ɽǶ�
  properties 
     center;     
  end
methods
function obj = g_Furion_cyliner_parabolic_collimation_Mirror( beam_in,ds,di,chi,theta,surface,r1,grating)   
    obj=obj@g_oe( beam_in,ds,di,chi,theta,surface,grating) ;      %�������������   
    obj.set_center(beam_in,ds,di,chi,theta,surface,r1,grating); %�����������ϵ�еĽ���ͷ�����  
    obj.reflect(beam_in,ds,di,chi,theta);               %���������
end
end

methods%�ڹ�ѧ������ϵ�У���������͹�ѧԪ�����Ľ���
    %[X2,Y2,Z2]�ǽ��㣬Ĭ�������ƽ�澵�Ľ������㷽��
    function [X2,Y2,Z2,T]=intersection(obj)
        
       T=obj.center.T;
       [X2,Y2,Z2]=obj.cneter_to_oe_p(obj.center.X2,obj.center.Y2,obj.center.Z2)  ;
      
    end
end
methods%�ڹ�ѧƽ������ϵ�У�ƽ�澵�ķ��߷���
    function [Nx,Ny,Nz]=normal(obj)
        [Nx,Ny,Nz]=obj.cneter_to_oe_v(obj.center.Nx,obj.center.Ny,obj.center.Nz) ; 
    end
end
methods%�����͹�ѧԪ����������� ��center����ϵת������ѧԪ��������ϵ
    function  [X2,Y2,Z2]=cneter_to_oe_p(obj,X,Y,Z)  
         n=obj.beam_in.n;
         OS=Furion_rotx(obj.theta)*((Furion_rotx(-2*obj.theta)*[X;Y;Z-obj.center.p])-repmat([0; 0;obj.center.r1],1,n));
         X2=OS(1,:) ;Y2=OS(2,:);Z2=OS(3,:);
    end 
end
methods%��ѧԪ�������� ��center����ϵ��ת������ѧԪ��������ϵ��
    function  [Nx,Ny,Nz]=cneter_to_oe_v(obj,L,M,N)            
         OV=(Furion_rotx(-obj.theta)*[L;M;N]);
         Nx=OV(1,:) ;Ny=OV(2,:) ;Nz=OV(3,:);
    end 
end

methods%����ת��Ϊcenter�������
    function set_center(obj, beam_in,ds,di,chi,theta,surface,r1,grating)
        obj.center =g_cyliner_parabolic_collimation( beam_in,ds,di,chi,theta,surface,r1,grating) ;
    end
end
end
