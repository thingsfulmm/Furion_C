classdef  g_paraboid_focus< g_cyliner_parabolic_focus%׷��phaseת���ɽǶ�
  properties 

  end
methods
function obj = g_paraboid_focus( beam_in,ds,di,chi,theta,surface,r2,grating)   
    obj=obj@g_cyliner_parabolic_focus( beam_in,ds,di,chi,theta,surface,r2,grating) ;%�������������
end
end

methods%�ڹ�ѧ������ϵ�У���������͹�ѧԪ�����Ľ���
    %[X2,Y2,Z2]�ǽ��㣬Ĭ�������ƽ�澵�Ľ������㷽��
    function [X2,Y2,Z2,T]=intersection(obj)
        L1=obj.L1;M1=obj.M1;N1=obj.N1;
        X1=obj.X1;Y1=obj.Y1;Z1=obj.Z1;
        
        A = M1.^2+L1.^2;
        B = 2*(N1.*obj.p+M1.*Y1+L1.*X1);
        C = X1.^2+Y1.^2+2*obj.p.*Z1;
        T = (-B+(B.^2-4*A.*C).^0.5)./(2*A);
        X2 = X1+T.*L1;                                                              %Nx=0
        Y2 = Y1+T.*M1; 
        Z2 = Z1+T.*N1;        
        obj.T=T;
    end
end



methods%�ڹ�ѧƽ������ϵ�У�ƽ�澵�ķ��߷���
    function [Nx,Ny,Nz]=normal(obj)
        Y2=obj.Y2;%Z2=obj.Z2;
        X2=obj.X2;
        Nx = -X2./(X2.^2+Y2.^2+obj.p^2).^0.5;
        Ny = -Y2./(X2.^2+Y2.^2+obj.p^2).^0.5;  
        Nz = -obj.p./(X2.^2+Y2.^2+obj.p^2).^0.5; 
        obj.Nx=Nx;
        obj.Ny=Ny;
        obj.Nz=Nz;
    end
end

end
