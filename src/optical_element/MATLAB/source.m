classdef source  <handle 
    %����࣬������ѧ�Ĺ�Դ    
    properties
        L;
        %�����������С ��λ [m]
        N;
        %������������ ��λ ��
        X;
        %�ⳡ��x���� ��λ[m] ��ά����
        Y;
        %�ⳡ��y���� ��λ [m] ��ά����
        sigma;
        %��˹�������ı�׼ƫ��
        field ;
        %���ÿ����ı���������һ����������ά����
        wavelength;
        %��Ĳ�������λ[m]
    end
    
    methods
        function obj =source(L,N,sigma,wavelength)
            obj.wavelength =wavelength;
            obj.L=L;
            obj.N =N;
            x = linspace(-obj.L/2,obj.L/2,obj.N);%ͨ��������С�ͳ�����Ŀ�γ� x ��������������ɵ��� ������ ��
            y = x';% ���� y ��������  y���������������� ��
            [X,Y] = meshgrid(x,y); % ������������������ X Y��X Y Ϊ��ά����
            obj.X=X;
            obj.Y =Y;           
            obj.sigma = sigma;
            obj.field = exp(-(X.^2+Y.^2)/2/(sigma)^2);%ͨ���������ɸ�˹�⣻       
        end        
    end
    
    methods
        function beam_=beam_out(obj)        
           beam_ = beam(obj.X,obj.Y,obj.field,obj.wavelength);%ͨ����Դ����������������
        end
    end
    
end
