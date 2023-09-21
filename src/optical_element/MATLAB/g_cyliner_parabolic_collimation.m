classdef  g_cyliner_parabolic_collimation< g_oe%׷��phaseת���ɽǶ�
  properties 
  
     T;
     r1;%��Բ��� ��λ[m]
     p;%�����߲���
     Nx;Ny;Nz%center����ϵ�У�������
  end
methods
function obj = g_cyliner_parabolic_collimation( beam_in,ds,di,chi,theta,surface,r1,grating)   
    obj=obj@g_oe( beam_in,ds,di,chi,theta,surface,grating) ;%�������������   
    obj.r1=r1;
    obj.p=r1*(1-cos(2*theta));
   obj.reflect(beam_in,ds,di,chi,theta);%���������
   
end
end

methods%�ڹ�ѧ������ϵ�У���������͹�ѧԪ�����Ľ���
    %[X2,Y2,Z2]�ǽ��㣬Ĭ�������ƽ�澵�Ľ������㷽��
    function [X2,Y2,Z2,T]=intersection(obj)
        L1=obj.L1;M1=obj.M1;N1=obj.N1;
        X1=obj.X1;Y1=obj.Y1;Z1=obj.Z1;
        
        A = M1.^2;
        B = 2*(-N1.*obj.p+M1.*Y1);
        C = Y1.^2-2*obj.p.*Z1;
        T = (-B+(B.^2-4*A.*C).^0.5)./(2*A); 
        X2 = X1+T.*L1;                                                              %Nx=0
        Y2 = Y1+T.*M1; 
        Z2 = Z1+T.*N1;        
        obj.T=T;
    end
end

methods%������ͷ��������ӹ�Դƽ��ת������ѧԪ����ƽ��
    function [ X1,Y1,Z1,L1,M1,N1 ]=source_to_oe( obj,X,Y,ds,L,M,N )
      n=length(X);
     OS =Furion_rotx(2*obj.theta)*(Furion_rotz(obj.chi)*[X;Y;repmat(obj.r1-ds,1,n)])...
    +repmat([0;0;obj.p/2],1,n);
    X1 = OS(1,:) ;Y1=OS(2,:);Z1=OS(3,:);

    OV = Furion_rotx(2*obj.theta)*Furion_rotz(obj.chi)*[L;M;N];
    L1 = OV(1,:) ;M1=OV(2,:) ;N1=OV(3,:);
    end
end

methods%�ڹ�ѧƽ������ϵ�У�ƽ�澵�ķ��߷���
    function [Nx,Ny,Nz]=normal(obj)
        Y2=obj.Y2;%Z2=obj.Z2;
        Ny=-Y2./(Y2.^2+obj.p^2).^0.5;  
        Nz=obj.p./(Y2.^2+obj.p^2).^0.5; 
        Nx=0*Ny;
        obj.Nx=Nx;
        obj.Ny=Ny;
        obj.Nz=Nz;
    end
end

methods%���㽻�㴦���͵�б�����
    function [h_slope,Y2]= h_slope(obj)             
        h_slope = 0*obj.X2;   
       Y2=obj.Y2+0;
    end
end
end
