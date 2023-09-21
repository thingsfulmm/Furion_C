classdef surfefile5 < no_surfe
    %  ������ά�������    
    properties
        meri_X;%�����������
        sag_Y;%��ʸ��������
        V;%�߶��������ֵ
    end
    
    methods 
        function obj = surfefile5(address)           %��ʼ������
            data = importdata(address);              %�ӵ�ַ�������ݣ���ʽΪ .dat��ʽ
            x1  =data(1,:);   x=x1(2:end)  ;            
            y1  =-data(:, 1)';y=y1(2:end);
            [Xd,Yd]=meshgrid(x,y); %���ò�ֵ�����С
            obj.meri_X=Xd;
            obj.sag_Y=Yd;
            obj.V     = data(2:end, 2:end)/0.495*0.427;%�߶�������ͨ������ϵ�����ı�߶����ֵ
        end
    end
    
      methods
              function Vq=value(obj,X,Y)           
                   Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,Y,X,'cubic',0);  %ͨ����ֵȡ���̶�λ�õĺ���ֵ        
              end
     end   
end

